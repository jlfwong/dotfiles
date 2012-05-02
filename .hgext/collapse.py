# collapse.py - collapse feature for mercurial
#
# Copyright 2009 Colin Caughie <c.caughie at indigovision dot com>
#
# This software may be used and distributed according to the terms
# of the GNU General Public License, incorporated herein by reference.

'''collapse multiple revisions into one
'''

from mercurial import util, repair, merge, cmdutil, commands
from mercurial.node import nullrev
from mercurial.i18n import _
import re

def collapse(ui, repo, **opts):
    """collapse multiple revisions into one

    Collapse combines multiple consecutive changesets into a single changeset,
    preserving any descendants of the final changeset. The commit messages for
    the collapsed changesets are concatenated and may be edited before the
    collapse is completed.
    """

    try:
        from mercurial import scmutil
        rng = scmutil.revrange(repo, opts['rev'])
    except ImportError:
        rng = cmdutil.revrange(repo, opts['rev'])

    if not rng:
        raise util.Abort(_('no revisions specified'))

    first = rng[0]
    last = rng[-1]
    revs = inbetween(repo, first, last)

    if not revs:
        raise util.Abort(_('revision %s is not an ancestor of revision %s\n') %
                            (first, last))
    elif len(revs) == 1:
        raise util.Abort(_('only one revision specified'))

    ui.debug(_('Collapsing revisions %s\n') % revs)

    for r in revs:
        if repo[r].user() != ui.username() and not opts['force']:
            raise util.Abort(_('revision %s does not belong to %s\n') %
                (r, ui.username()))
        if r != last:
            children = repo[r].children()
            if len(children) > 1:
                for c in children:
                    if not c.rev() in revs:
                        raise util.Abort(_('revision %s has child %s not '
                            'being collapsed, please rebase\n') % (r, c.rev()))
        if r != first:
            parents = repo[r].parents()
            if len(parents) > 1:
                for p in parents:
                    if not p.rev() in revs:
                        raise util.Abort(_('revision %s has parent %s not '
                            'being collapsed.') % (r, p.rev()))

    if len(repo[first].parents()) > 1:
        raise util.Abort(_('start revision %s has multiple parents, '
            'won\'t collapse.') % first)

    try:
        cmdutil.bailifchanged(repo)
    except AttributeError:
        cmdutil.bail_if_changed(repo)

    parent = repo[first].parents()[0]
    tomove = list(repo.changelog.descendants(last))
    movemap = dict.fromkeys(tomove, nullrev)
    ui.debug(_('will move revisions: %s\n') % tomove)

    origparent = repo['.'].rev()
    collapsed = None

    try:
        branch = repo[last].branch()
        collapsed = makecollapsed(ui, repo, parent, revs, branch, opts)
        movemap[max(revs)] = collapsed
        movedescendants(ui, repo, collapsed, tomove, movemap)
    except:
        merge.update(repo, repo[origparent].rev(), False, True, False)
        if collapsed:
            repair.strip(ui, repo, collapsed.node(), "strip")
        raise

    if not opts['keep']:
        ui.debug(_('stripping revision %d\n') % first)
        repair.strip(ui, repo, repo[first].node(), "strip")

    ui.status(_('collapse completed\n'))

def makecollapsed(ui, repo, parent, revs, branch, opts):
    'Creates the collapsed revision on top of parent'

    last = max(revs)
    ui.debug(_('updating to revision %d\n') % parent)
    merge.update(repo, parent.node(), False, False, False)
    ui.debug(_('reverting to revision %d\n') % last)
    recreaterev(ui, repo, last)
    repo.dirstate.setbranch(branch)
    msg = ''
    if opts['message'] != "" :
        msg = opts['message']
    else:
        first = True
        for r in revs:
            if not first:
                msg += '----------------\n'
            first = False
            msg += repo[r].description() + "\n"

        msg += "\nHG: Enter commit message.  Lines beginning with 'HG:' are removed.\n"
        msg += "HG: Remove all lines to abort the collapse operation.\n"

        if ui.config('ui', 'interactive') != 'off':
            msg = ui.edit(msg, ui.username())

        pattern = re.compile("^HG:.*\n", re.MULTILINE);
        msg  = re.sub(pattern, "", msg).strip();

    if not msg:
        raise util.Abort(_('empty commit message, collapse won\'t proceed'))

    newrev = repo.commit(
        text=msg,
        user=repo[last].user(),
        date=repo[last].date())

    return repo[newrev]

def movedescendants(ui, repo, collapsed, tomove, movemap):
    'Moves the descendants of the source revisions to the collapsed revision'

    sorted_tomove = list(tomove)
    sorted_tomove.sort()

    for r in sorted_tomove:
        ui.debug(_('moving revision %r\n') % r)
        parents = [p.rev() for p in repo[r].parents()]
        if len(parents) == 1:
            ui.debug(_('setting parent to %d\n') % movemap[parents[0]].rev())
            repo.dirstate.setparents(movemap[parents[0]].node())
        else:
            ui.debug(_('setting parents to %d and %d\n') %
                (movemap[parents[0]].rev(), movemap[parents[1]].rev()))
            repo.dirstate.setparents(movemap[parents[0]].node(),
                movemap[parents[1]].node())

        repo.dirstate.write()

        ui.debug(_('reverting to revision %d\n') % r)
        recreaterev(ui, repo, r)
        newrev = repo.commit(text=repo[r].description(), user=repo[r].user(),
                            date=repo[r].date())
        ctx = repo[newrev]
        movemap[r] = ctx

def recreaterev(ui, repo, rev):
    ui.debug(_('reverting to revision %d\n') % rev)
    commands.revert(ui, repo, rev=rev, all=True, date=None)

    wctx = repo[None]
    node = repo[rev]

    ss = node.substate

    for path, info in ss.items():
        ui.debug(_('updating subrepo %s to revision %s\n') % (path, info[1]))
        wctx.sub(path).get(info)

def inbetween(repo, first, last):
    'Return all revisions between first and last, inclusive'

    if first == last:
        return set([first])
    elif last < first:
        return set()

    parents = [p.rev() for p in repo[last].parents()]

    if not parents:
        return set()

    result = inbetween(repo, first, parents[0])
    if len(parents) == 2:
        result = result | inbetween(repo, first, parents[1])

    if result:
        result.add(last)

    return result

cmdtable = {
"collapse":
        (collapse,
        [
        ('r', 'rev', [], _('revisions to collapse')),
        ('', 'keep', False, _('keep original revisions')),
        ('f', 'force', False, _('force collapse of changes from different users')),
        ('m', 'message', "", _('use <text> as combined commit message'))
        ],
        _('hg collapse -r REVS [--keep | --keepbranches]')),
}

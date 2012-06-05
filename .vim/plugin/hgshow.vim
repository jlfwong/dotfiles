function! s:HgShow()
    execute 'vnew'
    execute 'silent r!hg log --stat -vpr .'
    execute 'set ft=diff'
    execute 'w! /tmp/hg-show'
    execute 'wincmd h'
    normal 1G
endf
command! -nargs=0 HgShow call s:HgShow()

function! s:HgDiff()
    execute 'vnew'
    execute 'silent r!hg diff'
    execute 'set ft=diff'
    execute 'w! /tmp/hg-diff'
    execute 'wincmd h'
    normal 1G
endf
command! -nargs=0 HgDiff call s:HgDiff()

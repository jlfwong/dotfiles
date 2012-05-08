setlocal ts=4 sw=4 sts=4
setlocal makeprg=python\ %
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

map <buffer> <Leader>c :!python %
map <buffer> <Leader>r :!python %

" http://www.morethanseven.net/2009/02/07/pdb-and-appengine.html 
abbr pdb! import pdb, sys; pdb.Pdb(stdin=sys.__stdin__, stdout=sys.__stdout__).set_trace()

abbr ipdb! import ipdb, sys; ipdb.Pdb(stdin=sys.__stdin__, stdout=sys.__stdout__).set_trace()

abbr ipy! import IPython; IPython.ipapi.launch_new_instance(dict(locals().items() + globals.items()))

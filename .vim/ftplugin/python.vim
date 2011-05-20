setlocal ts=4 sw=4 sts=4
setlocal makeprg=python\ %
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

map <buffer> <Leader>c :!python %
map <buffer> <Leader>r :!python %

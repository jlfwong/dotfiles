setlocal ts=4 sts=4 sw=4

map <buffer> <Leader>c :!markdown % > %:r.html
map <buffer> <Leader>r :!open -a "Google Chrome" %:r.html

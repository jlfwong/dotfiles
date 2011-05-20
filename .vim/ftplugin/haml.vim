setlocal ts=4 sw=4 sts=4
retab 2
map <buffer> <Leader>c :!haml % > %:r.html
map <buffer> <Leader>r :!open -a "Google Chrome" %:r.html

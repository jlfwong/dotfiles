setlocal sts=4 ts=4 sw=4
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

map <buffer> <Leader>c :!php\ -lq\ %
map <buffer> <Leader>r :!php %

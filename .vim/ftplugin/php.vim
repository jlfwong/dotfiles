setlocal sts=2 ts=2 sw=2
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

map <buffer> <Leader>c :!php\ -lq\ %
map <buffer> <Leader>r :!php %

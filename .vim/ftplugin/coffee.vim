setlocal sts=2 sw=2 ts=2

map <buffer> <Leader>a :e<C-R>=fnamemodify(expand('%'),':p:r')<CR>.js<CR>

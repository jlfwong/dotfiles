setlocal sts=4 sw=4 ts=4

map <buffer> <Leader>a :e<C-R>=fnamemodify(expand('%'),':p:r')<CR>.js<CR>

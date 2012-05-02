setlocal sts=4 sw=4 ts=4 expandtab

map <buffer> <Leader>c :!jslint "%"
map <buffer> <Leader>a :e<C-R>=fnamemodify(expand('%'),':p:r')<CR>.coffee<CR>

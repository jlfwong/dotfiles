setlocal sts=2 sw=2 ts=2 expandtab

map <buffer> <Leader>c :!jslint "%"
map <buffer> <Leader>a :e<C-R>=fnamemodify(expand('%'),':p:r')<CR>.coffee<CR>

if expand('%:p') =~ '/khan/'
  setlocal sts=4 sw=4 ts=4 expandtab
endif

setlocal ts=4 sw=4 sts=4

map <buffer> <Leader>c :!ghc -O3 -o %:r %
map <buffer> <Leader>r :!<C-R>=fnamemodify(expand('%'),':p:r')<CR>

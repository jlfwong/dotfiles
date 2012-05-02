setlocal sts=4 sw=4 ts=4 expandtab

" eclim goodness
" call SuperTabSetDefaultCompletionType("<c-x><c-u>")
" augroup eclim
"     autocmd!
"     autocmd BufWrite *.java :JavaImportMissing
"     autocmd BufWrite *.java :JavaImportClean
" augroup END

" nnoremap <buffer> <D-1> :JavaCorrect<CR>j
" nnoremap <buffer> <Leader>r :Java<CR>
" nnoremap <buffer> <Leader>c :Javac<CR>
map <buffer> <Leader>c :!javac %
map <buffer> <Leader>r :!java %:r

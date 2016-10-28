set ts=2 sts=2 sw=2

" Does this apply only for the buffer it's in?
" autocmd! BufWritePost <buffer> Make

autocmd FileType typescript :set makeprg=tsc\ --noEmit
nnoremap <buffer> <C-G><C-G> :YcmCompleter GoToDefinition<CR>
nnoremap <buffer> <C-G>g :YcmCompleter GoToDefinition<CR>
nnoremap <buffer> <C-G>u :YcmCompleter GoToReferences<CR>
nnoremap <buffer> <C-G>r :YcmCompleter RefactorRename 

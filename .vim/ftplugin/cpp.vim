setlocal sw=2 sts=2 ts=2
setlocal errorformat=%f:%l:\ %m

map <buffer> <Leader>c :!g++ -Wall -g -O2 -o %:r %
map <buffer> <Leader>r :!<C-R>=fnamemodify(expand('%'),':p:r')<CR>

if !exists("*SwitchSourceHeader")
  function! SwitchSourceHeader()
    if (expand ("%:e") == "cpp")
      find %:t:r.h
    else
      find %:t:r.cpp
    endif
  endfunction
endif

nnoremap <Leader>a :call SwitchSourceHeader()<CR>

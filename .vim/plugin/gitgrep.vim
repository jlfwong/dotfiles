function! s:GitGrep(query)
    redraw
    echo "Searching ..."

    let grepprg_bak=&grepprg
    let grepformat_bak=&grepformat
    try
        let &grepprg="git grep -n $*"
        let &grepformat="%f:%l:%m"
        silent execute "grep! " . a:query
    finally
        let &grepprg=grepprg_bak
        let &grepformat=grepformat_bak
    endtry

    botright copen
    redraw!
endfunction

command! -bang -nargs=* -complete=tag GitGrep call s:GitGrep(<q-args>)

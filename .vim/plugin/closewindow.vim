function! <SID>CloseIfOnlyWindow(force)
    " Performing :bd in a tab page will close the tab page, similar to
    " performing :bd in a split window
    if winnr('$') == 1 && (!exists('*tabpagenr') || tabpagenr('$') == 1)
        if a:force
            bd!
        else
            bd
        endif
    else
        if bufnr('#') == -1
            enew
        else
            if buflisted(bufnr('#'))
                b #
            else
                let bufnum = bufnr('$')
                while (bufnum == bufnr('%')) || ((bufnum > 0) && !buflisted(bufnum))
                    let bufnum = bufnum-1
                endwhile

                if (bufnum == 0)
                    enew
                else
                    exec "b " . bufnum
                endif
            endif
        endif
        if a:force
            bd! #
        else
            bd #
        endif
    endif
endfunction

" close current buffer without changing window layout
nmap <Leader>bd :call <SID>CloseIfOnlyWindow(0)<CR>
" Force close even if there are unsaved changes
nmap <Leader>bD :call <SID>CloseIfOnlyWindow(1)<CR>


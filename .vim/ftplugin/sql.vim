nmap <buffer> <silent> <Leader>xi :silent! %s/if.*\zethen/&\r/<CR>\|g/^then/normal ==<CR>
nmap <buffer> <silent> <Leader>xl :silent! %s/\(while\\|for\).*\zeloop/&\r/<CR>\|g/^loop/normal ==<CR>

function! <SID>FixFileSQL()
    set ff=unix
    silent! %s/\r\+$//
    set ts=6
    retab!
    normal \xi
    normal \xl
endfunction

nmap <buffer> <silent> <Leader>ff :call <SID>FixFileSQL()<CR>

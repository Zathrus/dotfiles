function! <SID>DiffPreview()
    tab split
    let ft=&ft
    diffthis
    vsplit
    enew
    set buftype=nofile
    silent read #
    silent 1 delete
    let &ft=ft
    diffthis
    wincmd l
endfunction

" view differences between the buffer and the file on disk
nmap <Leader>dp :call <SID>DiffPreview()<CR>


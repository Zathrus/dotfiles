" Find if/for/etc blocks that don't have a {, kinda.
nmap <buffer> <Leader>fi /^\s*\(#\|\/\)\@<!\<\(if\\|for\\|while\\|do\\|else\)\>.*\n\_s*\S{\@<!<CR>
" q puts brackets around a single line statement, used with \fi
" Note - this would be better if I could make it do a block rather than just
" a single line.
let @q='o{jo}\fi'
" r takes if (foo) {x}  and seperates it into multiple lines
let @r='ww%lcw{o}\fi'

" Find } followed by statements
nmap <buffer> <Leader>f} /}.\+<CR>

" Find { preceded by statements
nmap <buffer> <Leader>f{ /\S\+\s*{/e<CR>

" Find { plus empty line or empty line plus }
nmap <buffer> <Leader>fn /{\s*\n\s*\n\\|\n\s*\n\s*}/s+1<CR>

" Find foo * (I like foo*) that's not a comment ending
nmap <buffer> <Leader>f* /\S \+\*\(\**\/\)\@!/s+1<CR>
" p changes 'char *foo' to 'char* foo', used in conjunction with \f*
let @p='"_dw/[^*]i \f*'

" Fix blank lines before a block
nmap <buffer> <silent> <Leader>xp :silent! %s/^\n\+{/{<CR>

" Remove spaces after a ! (I hate ! foo  vs !foo)
nmap <buffer> <silent> <Leader>x! :silent! %s/!\s/!/g<CR>

" Fix if(/for(/etc to if (/ for (/ etc.
nmap <buffer> <silent> <Leader>xI :silent! %s/^\s*\<\(if\\|for\\|while\\|do\)\>\zs(/ (<CR>

" Fix (void *) to (void*)
nmap <buffer> <silent> <Leader>x* :silent! %s/\s\+\*)/*)/g<CR>

" Fix [ xxx ] to [xxx]
nmap <buffer> <silent> <Leader>x[ :silent! %s/\[\s\+/[/g<CR>
nmap <buffer> <silent> <Leader>x] :silent! %s/\s\+\]/]/g<CR>

" Fix empty comments
nmap <buffer> <silent> <Leader>x/ :silent! %g/^\s\+\/\/$/d<CR>

" Work in progress -- find func ( instead of func(
nmap <buffer> <Leader>f( /\(if\\|for\\|while\\|do\\|&&\\|\|\|\\|=\\|,\)\@<! (<CR>

function! <SID>FixFile()
    set ff=unix
    silent! %s/\r\+$//
    set ts=4
    retab!
    normal \xp
    normal \x,
    normal \xx,
    normal \x;
    normal \x!
    normal \xI
    normal \x(
    normal \x)
    normal \x*
    normal \x[
    normal \x]
    normal gg=G
endfunction

nmap <buffer> <silent> <Leader>ff :call <SID>FixFile()<CR>

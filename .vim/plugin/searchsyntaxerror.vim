" File:         SearchSyntaxError.vim
" Author:       Yakov Lerner <iler.ml at gmail.com>
" URL:          http://www.vim.org/scripts/script.php?script_id=1851
" Last change:  2007-04-04

" This scritp searches for the next syntax error detected by the vim highlighting 
" mechanism. To search for the next syntax error, issue command 
"       :ERR
" That all, folks.
"
" You can map search for next syntax error to your favourite key or
" key combination as follows:
"    noremap <silent><C-K><C-E>  :ERR<cr>
"    noremap <silent><C-K><C-E>  :ERR<cr>
"
" For feedback, bugs and wishes, write to: iler.ml at gmail.com
"
" As a bonus, :ERRP searches backwards for the syntax error.
" And <Ctrl-K><Ctrl-E> is mapped to :ERR, unless some other
" plugin or your own vimrc happen to define Ctrl-K Ctrl-E differently.

function! SearchSyntaxError(direction)
    " a:direction is '' for forward search, 'b' for backward search

    while search(".", "W" . a:direction) > 0
            " while search("[(){}\\[\\]?;:]", "W") > 0 -- can be faster, but not always correct.
        let syntax = synIDattr( synIDtrans(synID(line("."),col("."),1)), "name")
        if syntax =~ "Error"
                echo "Syntax Error Found"
                return
        endif
    endw
    redraw
    echo "No syntax errors found."
endfun

function! PreviousSyntaxError()
    call SearchSyntaxError('b')
endfun

"
" command :ERR -- search next syntax error detected by the vim highlighting mechanism.
"
:command! ERR  call SearchSyntaxError('')

"map <silent><F10>       :ERR<cr>
noremap <silent><C-K><C-E>  :ERR<cr>

"
" command :ERRP  -- search previous syntax error detected by the vim highlighting mechanism.
"
:command! ERRP  call PreviousSyntaxError()

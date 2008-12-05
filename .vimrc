let s:oldrtp=&rtp
set nocompatible        " disable horrible vi compatability mode!
set all&                " Reset all settings to default
let &rtp=s:oldrtp

"set bg=light            " this should not be necessary, bug in 7
colorscheme desert256

syntax enable           " syntax highlighting if available
filetype plugin indent on  " enable special 'stuff' based on filetype
"set autoindent          " keep indent levels line-to-line
set backspace=indent,eol,start   " allow backspacing over these
set nobackup            " disable backups
set cinoptions=:0g0h1st0(0
                        " change some cindent options
set complete-=i         " do not scan included files in completion
set noerrorbells        " no audible bells
set expandtab           " expand tabs to spaces
if v:version > 600
    set foldenable          " enable folding
    set foldmethod=syntax   " fold by syntax
    set foldlevel=100       " default fold level very high
endif
set hidden              " allow modified buffers to be hidden
set history=1000        " more : command history
set hlsearch            " highlight searches
set ignorecase          " ignore case on searches by default
set incsearch           " do incremental searches
set laststatus=2        " always show the status line
set lazyredraw          " don't redraw during macros
set linespace=1         " I like the extra spacing
set makeprg=gmake       " use gmake
"set mouse=a             " Enable mouse in all modes
set mousemodel=popup_setpos  " change right click to set position and make menu
set pastetoggle=<F12>   " F12 to move in/out of paste mode
set report=0            " always report # of lines changed from : commands
set ruler               " show the cursor position in the status bar
set scrolljump=-25      " if you have to scroll, scroll at least 1/4 screen
set shiftwidth=4        " number of spaces to indent for various operations
set showcmd             " show partial commands in status line
set smartcase           " searches are case-insensitive unless upper case used
set smarttab            " use shiftwidth instead of tabstop at start of line
set softtabstop=4       " number of spaces a tab counts for
if v:version > 700
    set spelllang=en_us     " use US English for spelling
endif
set nostartofline       " don't go to start of line in many cases
set suffixes-=.h        " Really, I like editing header files
set title               " change the window title based on file being edited
set novisualbell        " no visual bells
set whichwrap+=<,>,[,]  " wrap at start/end of line
set wildmenu            " display menu in : command-completion mode
set wildmode=full

if has("win32") || has("win64")
    let Tlist_Ctags_Cmd='ctags.exe'
    set cscopeprg='cscope.exe'
    set rtp=$HOME/.vim,$HOME/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/vimfiles/after,$HOME/.vim/after
endif

if has("gui_running")
    set lines=40
    set guioptions-=T

    if has("win32")
        set guifont=Lucida_Console:h10:cANSI
        noremap <M-Space> :simalt ~<CR>
        inoremap <M-Space> <C-O>:simalt ~<CR>
        cnoremap <M-Space> <C-C>:simalt ~<CR>
    endif
else
    "set bg=dark
    set clipboard=exclude:.*

    if &term == 'screen'
        set t_Co=256
    endif
endif

if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

set tags=~/sita/BagManager/tags

" MiniBufExpl  stuff
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMaxSize = 5
let g:miniBufExplorerMoreThanOne=1
let g:miniBufExplUseSingleClick = 1

noremap <F4> :cd %:p:h<CR>

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

nmap <Leader>bd :call <SID>CloseIfOnlyWindow(0)<CR>
" Force close even if there are unsaved changes
nmap <Leader>bD :call <SID>CloseIfOnlyWindow(1)<CR>

" Remove all trailing whitespace in a file and return the cursor to its
" original position
function! RemoveTrailingWhitespace()
    if &ft =~? 'diff\|mail\|make'
        return
    endif
    let l:searchreg = getreg('/')
    let l:searchregtype = getregtype('/')
    let l:curcol = col(".")
    let l:curline = line(".")
    " use silent! so we suppress the 'pattern not found' message
    silent! %s/\s\+$//
    call cursor(l:curline, l:curcol)
    call setreg('/', l:searchreg, l:searchregtype)
endfunction

autocmd BufWritePre * call RemoveTrailingWhitespace()

function! <SID>DiffPreview()
    tabedit %
    diffthis
    vsplit
    enew
    set buftype=nofile
    read #
    1 delete
    diffthis
endfunction

nmap <Leader>dp :call <SID>DiffPreview()<CR>

nmap <Leader>l :ls<CR>:b<space>

nnoremap <silent> <C-L> :nohls<CR><C-L>

let c_gnu = 1                   " GNU gcc specifics
let c_comment_strings = 1       " Highlight strings and numbers inside comments
let c_space_errors = 1          " Trailing whitespace, spaces before a tab

autocmd FileType help nnoremap <buffer> <Enter> <C-]>

" Find lines >80 chars long
nmap <Leader>f8 /^.\{-}\zs.\%>81v<CR>

" Find two spaces after a period -- we don't fix because we could be wrong
nmap <Leader>f. /\.  \w/s+1<CR>

" Find things like "why ?" and "now !". No need for that idiotic space.
nmap <Leader>f! /\w \(?\\|!\)=\@!/s+1<CR>

" Find multiple newlines together
nmap <Leader>fN /^\(^}\n\)\@<!\n\n<CR>


" Fix commas without a following space unless they're in strings
nmap <silent> <Leader>x, :silent! %s/\(\(^\([^"']*\(["'][^"']*["']\)\)*[^"']*\)\@<=\)\+,\ze\S/& /g<CR>

" Fix ( foo ) to (foo)
nmap <silent> <Leader>x( :silent! %s/(\s\+/(/g<CR>
nmap <silent> <Leader>x) :silent! %s/\s\+)/)/g<CR>

" Fix ; with leading spaces
nmap <silent> <Leader>x; :silent! %s/\s\+;/;/g<CR>

" Fix , with leading spaces
nmap <silent> <Leader>xx, :silent! %s/\s\+,/,/g<CR>

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

nmap <C-]> :exe "tjump " . expand('<cword>')<CR>

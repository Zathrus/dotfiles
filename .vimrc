" -----------------------------------------------------------------------{{{1
" Reset settings -- do not trust the system vimrc or any other files that may
" get loaded.
let s:oldrtp=&rtp
set nocompatible        " disable horrible vi compatability mode!
set all&                " Reset all settings to default
let &rtp=s:oldrtp

" Make Windows use the standard .vim dir instead of _vimfiles -- this must be
" done before :filetype or :syntax.  Also beat Windows into using utf-8.
if (has("win32") || has("win64"))
    set rtp=$HOME/.vim,$HOME/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/vimfiles/after,$HOME/.vim/after
    set enc=utf-8

    if has("gui_running")
        set bg=light            " this should not be necessary, bug in 7
    endif
endif

" Misc ------------------------------------------------------------------{{{1
filetype indent plugin on
set nostartofline       " don't go to start of line in many cases

" Colors, syntax, etc. --------------------------------------------------{{{1

colorscheme desert256
syntax enable           " syntax highlighting if available

" Files, Backup ---------------------------------------------------------{{{1
set history=1000        " size of command and search history
set viminfo='100,<1000,s1000
"           |    |     |
"           |    |     +-- Exclude registers larger than X kb
"           |    +-------- Maximum of X lines for registers
"           +------------- Keep marks for X files

" enable backups and use the first available dir
set backup
set backupdir=~/tmp/vim,~/local/backup,./,/tmp
set suffixes-=.h        " Really, I like editing header files

" Indentation & Text Formatting -----------------------------------------{{{1
set autoindent          " keep indent levels line-to-line
set expandtab           " expand tabs to spaces
set smarttab            " use shiftwidth instead of tabstop at start of line
set shiftwidth=4        " number of spaces to indent for various operations
set softtabstop=4       " number of spaces a tab counts for

set cinoptions=:0g0h1st0(0
"              | | |  | |
"              | | |  | +-- line up after ( on new line
"              | | |  +---- do not indent function return values
"              | | +------- Indent N shiftwidths after a scope declaration
"              | +--------- Do not indent scope delcarations
"              +----------- Do not indent case statements from the switch

set textwidth=78        " Max line length is X
set formatoptions-=t    " Disable text autowrapping
set formatoptions+=corqna
"                  ||||||
"                  |||||+-- auto-reformat text (comments only)
"                  ||||+--- recognize lists
"                  |||+---- Allow reformatting of comments with gq
"                  ||+----- Insert comment leader after <CR>
"                  |+------ Insert comment leader after o/O
"                  +------- wrap comments at textwidth

set backspace=indent,eol,start   " allow backspacing over these
set linebreak                    " wrap lines at sensible places (if wrap is on)
set pastetoggle=<F12>            " F12 to move in/out of paste mode

" Use better looking listchars if they are supported
if has("multi_byte")
    set listchars=tab:»\ ,extends:›,precedes:‹,trail:·,nbsp:✂,eol:$
else
    set listchars=tab:>\ ,extends:>,precedes:<,trail:-,nbsp:%,eol:$
endif

let &sbr = nr2char(8618).' ' " Show ↪ at the beginning of wrapped lines

" Folding ----------------------------------------------------------------{{1
if v:version > 600
    set foldenable          " enable folding
    set foldmethod=syntax   " fold by syntax
    set foldlevel=100       " default fold level very high
endif

" Searching --------------------------------------------------------------{{1
set hlsearch            " highlight searches
set incsearch           " do incremental searches
set ignorecase          " ignore case on searches by default
set smartcase           " searches are case-insensitive unless upper case used
set report=0            " always report # of lines changed from : commands
let loaded_matchparen=1 " Disable matching paren/brace highlighting

" Load improved % behavior
source $VIMRUNTIME/macros/matchit.vim

" Menus, completion ------------------------------------------------------{{1
"set complete-=i         " do not scan included files in completion
set completeopt=longest,menu,menuone,preview
"               |       |    |       |
"               |       |    |       +-- show info in preview window
"               |       |    +---------- show menu even with one match
"               |       +--------------- display popup menu
"               +----------------------- insert longest completion match

set infercase           " Adjust completions for case
set wildmenu            " display menu in : command-completion mode
set wildmode=full
set shellslash          " use slashes instead of backslashes

" Buffers, Windows, & Tabs
set hidden              " allow modified buffers that are not visible
set mousemodel=popup    " change right click to set position and make menu

" Display, messages, and terminal ----------------------------------------{{1
set display=lastline    " show as much of the last displayed line as possible
set laststatus=2        " always show the status line
set lazyredraw          " don't redraw during macros
set noruler             " since statusline is set, let ctrl-g show position
set showcmd             " show partial commands in status line
set scrolloff=5         " keep N lines visible when scrolling up/down
set sidescrolloff=5     " keep N chars visible when scrolling left/right
set title               " change the window title based on file being edited
set ttyfast             " why yes, my terminal isn't from the 70s.
set linespace=1         " I like the extra spacing
set whichwrap+=<,>,[,]  " wrap at start/end of line

set statusline=%!GetStatusLine() " Set statusline from a function

set printoptions=paper:letter

" Disable error bells entirely -- turn off optional ones, turn on the visual
" bell, and then set the visualbell to do nothing.
set noerrorbells
set novisualbell t_vb=
autocmd GuiEnter * set t_vb=

" Custom functions -------------------------------------------------------{{1

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

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

" Returns the string used for the status line
function! GetStatusLine()
    let line = ''
    let line .= '[%n] '                         " Buffer number
    let line .= '%<%f'                          " Filename
    let line .= '%4m'                           " Modified flag
    let line .= '%5r'                           " Readonly flag
    let line .= '%10w'                          " Preview flag
    let line .= '%6h'                           " Help flag
    let line .= '[%{&ff}] '                     " File format
    let line .= "[%{(&fenc!=''?&fenc:&enc)}] "  " File encoding
    let line .= '%y '                           " File type
    let line .= '%='                    " Left/right separator
    let line .= '(%b/%B) '                      " dec/hex of char under cursor
    let line .= '[%o] '                         " Byte number
    let line .= '%l,%c%V/%L '                   " Position line,column/total
    let line .= '%P'                            " Percentage through file
    return line
endfunction

" Custom maps ------------------------------------------------------------{{1

" cd to current buffer's directory
noremap <F4> :cd %:p:h<CR>

" view differences between the buffer and the file on disk
nmap <Leader>dp :call <SID>DiffPreview()<CR>

" List all open buffers and select one
nmap <Leader>l :ls<CR>:b<space>

" redraw screen and clear highlight as same time
nnoremap <silent> <C-L> :nohls<CR><C-L>

" completion mode maps
inoremap <C-SPACE> <C-X><C-O>
inoremap <C-L> <C-X><C-L>
inoremap <C-]> <C-X><C-]>
inoremap <expr> <esc> pumvisible() ? "\<c-e>" : "\<esc>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

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

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

nmap <C-]> :exe "tjump " . expand('<cword>')<CR>

" Custom autocommands ----------------------------------------------------{{1
autocmd BufWritePre * call RemoveTrailingWhitespace()

autocmd FileType help nnoremap <buffer> <Enter> <C-]>

" Plugin settings --------------------------------------------------------{{1
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    if has("win32") || has("win64")
        set cscopeprg='cscope.exe'
    endif
endif

set tags=~/sita/BagManager/tags

let g:miniBufExplMaxSize = 5            " maximum 5 lines
let g:miniBufExplorerMoreThanOne=1      " Always show the MBE window
let g:miniBufExplUseSingleClick=1       " Switch w/ a single mouse click

let c_gnu = 1                   " GNU gcc specifics
let c_comment_strings = 1       " Highlight strings and numbers inside comments
let c_space_errors = 1          " Trailing whitespace, spaces before a tab

" GVim setup -------------------------------------------------------------{{1
if has("gui_running")
    set lines=40
    set guioptions-=T

    if has("win32")
        set guifont=DejaVu_Sans_Mono:h10:cANSI
        noremap <M-Space> :simalt ~<CR>
        inoremap <M-Space> <C-O>:simalt ~<CR>
        cnoremap <M-Space> <C-C>:simalt ~<CR>
    endif
else
    set clipboard=exclude:.*

    if &term == 'screen'
        set t_Co=256
    endif
endif

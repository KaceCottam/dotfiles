"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/.buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/.buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'ElmCast/elm-vim'
Plug 'vim-scripts/mips.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'morhetz/gruvbox'
Plug 'justinmk/vim-sneak'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-unimpaired'
Plug 'honza/vim-snippets'
Plug 'kana/vim-niceblock'
Plug 'machakann/vim-highlightedyank'
Plug 'markonm/traces.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'romainl/vim-cool'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'tomasr/molokai'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  call append(0, "#ifndef " . gatename)
  call append(1, "#define " . gatename)
  call append(2, "\n")
  call append(3, "#endif // ! " . gatename)
  execute ":goto " . line2byte(3)
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

function! s:create_ifnexist()
  let filename = expand("%:p:h") . expand("<cfile>")
  execute "edit " . filename
endfunction

set number relativenumber

command! Reload :so ~/.vimrc
colorscheme gruvbox

nnoremap <Leader>= :Tab/\zs=
nnoremap <Leader>& :Tab/&
nnoremap <Leader>; A;<Esc>j
nnoremap <Leader>/ <Leader>c<Space>

command! Format :%py3f /usr/bin/clang-format.py
nmap <silent> <Leader>f :Format<CR>
autocmd BufWritePre *{.c,.h,.cxx,.hxx,.cpp,.hpp} :Format
"autocmd BufWritePost ~/.vimrc :Reload
autocmd BufRead *.asm :set ft=mips
nnoremap j gj
nnoremap k gk

set colorcolumn=80
set shortmess=atI
set showmode
set title
set noerrorbells
set nostartofline
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
set laststatus=2
set cursorline
set scrolloff=3

set ttyfast
set autoread
set modeline
set modelines=4
set exrc
set secure
set esckeys
set backspace=indent,eol,start
set ignorecase
set smartcase
set hidden
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,default,latin1
set ffs=unix,dos,mac

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists('&undodir')
  set undodir=~/.vim/undo
  set undofile
endif

set backupskip=/tmp/*,/private/tmp/*

" Hide menu bar
set guioptions-=m

" Hide toolbar
set guioptions-=T

" Hide left-hand scrollbar
set guioptions-=L

" Hide right-hand scrollbar
set guioptions-=r

" Hide bottom scrollbar
set guioptions-=b

set guifont="Hack 10"


" Make comments italic
highlight Comment gui=italic

nnoremap Y y$

nmap <silent> ]b :bnext<CR>
nmap <silent> [b :bprevious<CR>

nmap <silent> ]t :tabnext<CR>
nmap <silent> [t :tabprevious<CR>

" Save as superuser
nnoremap <Leader>W :w !sudo tee % > /dev/null<CR>
" Yank full path of current buffer
nnoremap <silent> <Leader>yf :let @+ = expand("%:p")<CR>
" Yank relative path of current buffer
nnoremap <silent> <Leader>yn :let @+ = expand("%")<CR>

autocmd FileType help nnoremap <buffer> q :q<CR>
autocmd FileType qf nnoremap <buffer> q :q<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = "unique_tail_improved"

nmap <C-n> <Plug>AirlineSelectNextTab
nmap <C-p> <Plug>AirlineSelectPrevTab

nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9

"*********************************************************************
" vim-airline/vim-airline-themes
"*********************************************************************

let g:airline_theme = "gruvbox"

"*********************************************************************
" w0rp/ale
"*********************************************************************

let g:ale_sign_error = get(g:, 'ale_sign_error', "×")
let g:ale_sign_warning = get(g:, 'ale_sign_warning', "¤")
let g:ale_lint_on_text_changed = get(g:, 'ale_lint_on_text_changed', 'never')
let g:ale_lint_on_enter = get(g:, 'ale_lint_on_enter', 0)
let g:ale_linters = get(g:, 'ale_linters', {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint'],
      \ 'python': ['pylint'],
      \ })
let g:ale_pattern_options = get(g:, 'ale_pattern_options', {
      \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
      \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
      \ })

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_lint)

nmap <silent> ]a <Plug>(ale_previous_wrap)
nmap <silent> [a <Plug>(ale_next_wrap)

let g:cpp_class_scope_highlight = get(g:, 'cpp_class_scope_highlight', 1)
let g:cpp_class_decl_highlight = get(g:, 'cpp_class_decl_highlight', 1)
let g:cpp_no_function_highlight = get(g:, 'cpp_no_function_highlight', 1)

let g:sneak#label = get(g:, 'sneak#lable', 1)


map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit = get(g:, 'UltiSnipsEditSplit', 'vertical')
let g:UltiSnipsExpandTrigger = get(g:, 'UltiSnipsExpandTrigger', '<C-j>')
let g:UltiSnipsSnippetsDir = get(g:, 'UltiSnipsSnippetsDir', '~/.vim/snips')

let g:ycm_key_list_select_completion =
      \ get(g:, 'ycm_key_list_select_completion', ['<TAB>', '<C-n>', '<Down>'])
let g:ycm_key_list_previous_completion =
      \ get(g:, 'ycm_key_list_previous_completion', ['<S-TAB>', '<C-p>', '<Up>'])
let g:ycm_auto_trigger =
      \ get(g:, 'ycm_auto_trigger', 1)
let g:ycm_autoclose_preview_window_after_insertion =
      \ get(g:, 'ycm_autoclose_preview_window_after_insertion', 1)
let g:ycm_seed_identifiers_with_syntax =
      \ get(g:, 'ycm_seed_identifiers_with_syntax', 1)
let g:ycm_collect_identifiers_from_comments_and_strings =
      \ get(g:, 'ycm_collect_identifiers_from_comments_and_strings', 1)
let g:ycm_global_ycm_extra_conf =
      \ '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_python_binary_path =
      \ get(g:, 'ycm_python_binary_path', 'python')
let g:ycm_show_diagnostics_ui =
      \ get(g:, 'ycm_show_diagnostics_ui', 0)
let g:ycm_key_detailed_diagnostics =
      \ get(g:, 'ycm_key_detailed_diagnostics', '')
let g:ycm_semantic_triggers = get(g:, 'ycm_semantic_triggers', {
      \ 'c': ['->', '.', 're!\w{3}'],
      \ 'cpp': ['->', '.', '::', 're!\w{3}'],
      \ 'cs' : ['.', 're!\w{3}'],
      \ 'cuda': ['->', '.', '::', 're!\w{3}'],
      \ 'd' : ['.', 're!\w{3}'],
      \ 'elixir' : ['.', 're!\w{3}'],
      \ 'elm' : ['.', 're!\w{3}'],
      \ 'erlang': [':'],
      \ 'go' : ['.', 're!\w{3}'],
      \ 'java' : ['.', 're!\w{3}'],
      \ 'javascript' : ['.', 're!\w{3}'],
      \ 'javascript.jsx' : ['.', 're!\w{3}'],
      \ 'lua': ['.', ':'],
      \ 'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
      \ 'objcpp': ['->', '.', '::', 're!\w{3}'],
      \ 'ocaml': ['.', '#'],
      \ 'perl': ['->'],
      \ 'perl6' : ['.', 're!\w{3}'],
      \ 'php': ['->', '::'],
      \ 'python' : ['.', 're!\w{3}'],
      \ 'ruby': ['.', '::'],
      \ 'scala' : ['.', 're!\w{3}'],
      \ 'sh': ['re![\w-]{2}', '/', '-'],
      \ 'typescript' : ['.', 're!\w{3}'],
      \ 'typescript.tsx' : ['.', 're!\w{3}'],
      \ 'vb' : ['.', 're!\w{3}'],
      \ 'vim': ['re![_a-zA-Z]+[_\w]*\.'],
      \ 'zsh': ['re![\w-]{2}', '/', '-'],
      \ })
let g:ycm_filetype_whitelist = get(g:, 'ycm_filetype_whitelist', {
      \ 'c': 1,
      \ 'cpp': 1,
      \ 'go': 1,
      \ 'java': 1,
      \ 'javascript': 1,
      \ 'javascript.jsx': 1,
      \ 'python': 1,
      \ 'sh': 1,
      \ 'typescript': 1,
      \ 'typescript.tsx': 1,
      \ 'vim': 1,
      \ 'zsh': 1,
      \ })

let g:ycm_min_num_of_chars_for_completion=5
let g:ycm_max_num_candidates=5
let g:ycm_enable_diagnostic_signs=0

nnoremap <Leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>ji :YcmCompleter GoToInclude<CR>
nnoremap <Leader>jj :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>jr :YcmCompleter GoToReferences<CR>

nnoremap <LocalLeader>K :YcmCompleter GetDoc<CR>
nnoremap <LocalLeader>k :YcmCompleter GetType<CR>

nnoremap gf :execute ":edit " . expand('%:h') . "/" . expand('<cfile>')<CR>

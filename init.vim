"            _
"           (_)
"     __   ___ _ __ ___  _ __ ___
"     \ \ / / | '_ ` _ \| '__/ __|
"      \ V /| | | | | | | | | (__
"     (_)_/ |_|_| |_| |_|_|  \___|
" by m3tro1d

" Basics {{{
let mapleader=' '
set spelllang=en_us,ru_ru
if has('win32')
  language en_US
else
  language en_US.UTF-8
endif
" Less command history
set history=500
" Compatibility settings
set nocompatible
set encoding=utf-8
scriptencoding utf-8
filetype plugin indent on
" Python path
if has('win32')
  let g:python3_host_prog = $LOCALAPPDATA . '\Programs\Python\Python310\python.exe'
else
  let g:python3_host_prog = '/bin/python3'
endif
" }}}

" Behavior {{{
" General autocommands group
augroup settings
  autocmd!
augroup END
" Don't load netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" Priority of EOF formats
set fileformats=unix,dos
" Priority of encodings
set fileencodings=utf-8,cp1251,cp866,koi8-r
" Automatically hide buffer when it's unsaved (also allows to use :bufdo)
set hidden
" Ask if there are unsaved files
set confirm
" Longer updatetime (def: 4000 ms) leads to delays and poor UX
set updatetime=100
" Waiting interval for the mapped sequences
set ttimeoutlen=10
" Waiting interval for the mapped commands
set timeoutlen=500
" Disable swap files
set noswapfile
" Disable backup files
set nobackup nowritebackup
" Auto completion for files and commands
set wildmenu wildignorecase
set wildmode=longest,list,full
set wildignore+=*.swp,*.bak
set wildignore+=*.exe,*.o,*.obj
set wildignore+=*/.git/*,*/__pycache__/*,*/node_modules/*
set wildignore+=*/var/*,*/vendor/*,*/public/build/*
" Treat 'kebab' identifiers like a whole word
set iskeyword+=-
" Recursive :find in the current directory
set path=.,**
" Less aggressive completion
set completeopt=menuone,noselect
" Don't display completion messages
set shortmess+=c
" Don't jump to matching pairs
set noshowmatch
" Split windows at the bottom and right
set splitbelow splitright
" Don't update screen while running macros (makes them faster & uses less resources)
set lazyredraw
" Jump to the buffer window instead of switching if it's already opened in another window
set switchbuf=useopen
" Preview for :s command
set inccommand=nosplit
" Treat numbers as either decimal or hex when using CTRL-A|X
set nrformats=hex
" Disable directory-specific settings files
set noexrc
" Disable dangerous settings (autocommands, shell and write commands) in the modeline and .exrc
set secure
" Allow backspace in insert mode
set backspace=indent,eol,start
" Keeps only one whitespace when joining lines
set nojoinspaces
" Don't beep or flash on errors
set noerrorbells novisualbell t_vb=
" Use slower but better diff algorithm
set diffopt+=internal,algorithm:patience
" Reload file automatically if it was changed
set autoread
autocmd settings FocusGained,BufEnter * checktime
" Auto-resize splits when the program window gets resized
autocmd settings VimResized * wincmd=
" Automatically reload vimrc
autocmd settings BufWritePost $MYVIMRC source $MYVIMRC
" Close some windows using q
autocmd settings FileType help,qf,fugitive,fugitiveblame nnoremap <buffer> <silent> q :close<CR>
" Highlight region on yank
autocmd settings TextYankPost * silent! lua require 'vim.highlight'.on_yank { higroup = 'IncSearch', timeout = 50, on_visual = false }
" }}}

" Appearance {{{
" Theme settings
syntax enable
if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme everforest
" Line numbering
set number relativenumber
" Show cursor position
set ruler
" Always show statusline
set laststatus=2
" Hide the mouse pointer when typing
set mousehide
" Height of the cmd line (bigger helps avoiding hit-enter prompt)
set cmdheight=2
" Smaller completion menu
set pumheight=10
" Show current commands in the bottom-right corner
set showcmd
" Don't show current mode in the command line
set noshowmode
" Highlight current line
set cursorline
" Set the window's title to the current filename
set title titlestring=%{expand(\'%:t\')}
" }}}

" Search {{{
" Disable search results highlighting
set nohlsearch
" Show results while typing
set incsearch
" Search at the beginning when hitting end of file
set wrapscan
" Ignore case if query is lowercase (use \C to force match case)
set ignorecase smartcase
" }}}

" Indentation {{{
" Automatic indentation
set autoindent smartindent
" Do not indent cases in switch and indent scope declarations in C++ classes (use :Ng0 for custom indent)
set cinoptions=:0g0
" Use existing indentation settings in this file for new lines
set copyindent
" Show tab as 4 spaces
set tabstop=4
" White spaces instead of tabs by default
set expandtab
" Number of spaces shifted with <, >
set shiftwidth=2
" Number of spaces to be deleted and inserted with Backspace (negative to use shiftwidth)
set softtabstop=-1
" Round the indentation to shiftwidth when shifting with <, >
set shiftround
" }}}

" Text display {{{
" Don't break lines automatically
set textwidth=0
" Wrap text and break the lines by words
set wrap linebreak
" Proper indentation for wrapped lines
set breakindent breakindentopt=shift:2
" Show line wrappings
set showbreak=»
" Always try to show paragraph's last line
set display+=lastline
" Make 1 line above, below and sideways the cursor always visible
set scrolloff=1 sidescrolloff=1
" Turn off concealing by default
set conceallevel=0
" }}}

" Mappings {{{
" Disable mouse wheel pasting
nmap <silent> <MiddleMouse> <nop>
imap <silent> <MiddleMouse> <nop>
" Disable Ex mode
nnoremap <silent> Q <nop>
" Change and delete to blackhole register
nnoremap <silent> c "_c
vnoremap <silent> c "_c
nnoremap <silent> C "_C
nnoremap <silent> x "_x
vnoremap <silent> x "_x
nnoremap <silent> X "_X
" Intuitive yank (like D)
nnoremap <silent> Y y$
" Intuitive replace
vnoremap <silent> p pgvy
" Keep the selection after indenting
vnoremap <silent> < <gv
vnoremap <silent> > >gv
" Center the screen on certain actions in order not to get lost
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> <expr> J v:count ? 'J' : 'mzJ`z'
" Moving text
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
" Intuitive line movement (if count is not provided, move by displayed lines)
nnoremap <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count ? 'k' : 'gk'
" Faster movement between windows
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Window resizing
nnoremap <silent> <Right> :vertical resize +2<CR>
nnoremap <silent> <Left> :vertical resize -2<CR>
nnoremap <silent> <Up> :resize +2<CR>
nnoremap <silent> <Down> :resize -2<CR>
" Toggle 2 vertical and horizontal splits
nnoremap <silent> <leader>th <C-w>t<C-w>K
nnoremap <silent> <leader>tv <C-w>t<C-w>H
" Copy and paste using system clipboard
nnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>p "+p
" Some mappings for the buffers
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [B :bfirst<CR>
" Quickfix list navigation
nnoremap <silent> ]q :cnext<CR>zzzv
nnoremap <silent> [q :cprevious<CR>zzzv
nnoremap <silent> ]Q :clast<CR>zzzv
nnoremap <silent> [Q :cfirst<CR>zzzv
" Arguments navigation
nnoremap <silent> ]n :next<CR>
nnoremap <silent> [n :previous<CR>
nnoremap <silent> ]N :last<CR>
nnoremap <silent> [N :first<CR>
" Toggle spell check
nnoremap <silent> <leader>s :setlocal spell!<CR>
" Comfortable editing in command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
" Get current directory in the command mode
cnoremap %% <C-r>=expand('%:p:h')<CR>\
" More convenient terminal
tnoremap <silent> <Esc> <C-\><C-n>
tnoremap <silent> <C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-l> <C-\><C-n><C-w>l
" }}}

" Russian keymap {{{
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
inoremap <silent> <C-j> <C-^>
autocmd settings InsertLeave * set iminsert=0
" }}}

" Some custom functions and commands {{{
" Quickfix list toggle {{{
function! QuickfixToggle() abort
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction
" }}}
nnoremap <silent> <leader>q :call QuickfixToggle()<CR>

" Virtual edit (cursor beyond EOL) {{{
function! VirtualEditToggle() abort
  if &ve == ''
    setlocal ve=all
    echo 'Virtual edit: ON.'
  else
    setlocal ve=
    echo 'Virtual edit: OFF.'
  endif
endfunction " }}}
command! VirtualEditToggle call VirtualEditToggle()

" Clean-up trailing whitespaces & newlines at EOF {{{
function! CleanTrailings() abort
  let save_cursor = getpos('.')
  let old_query = getreg('/')
  " Trailing whitespaces
  silent! %s/\s\+$//e
  " Blank lines at EOF
  silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction " }}}
command! CleanTrailings call CleanTrailings()

" Quickly change indentaion spaces amount {{{
function! ChangeTabstops(current, new) abort
  let &l:tabstop = a:current
  let &l:shiftwidth = a:current
  setlocal noexpandtab
  retab!
  let &l:tabstop = a:new
  let &l:shiftwidth = a:new
  setlocal expandtab
  retab
endf
" }}}
command! -nargs=* ChangeTabstops call ChangeTabstops(<f-args>)

" Empty registers {{{
function! EmptyRegisters() abort
  let regs = split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfunction
" }}}
command! EmptyRegisters call EmptyRegisters()

" Simple sort motion {{{
function! Sort(type, ...)
  '[,']sort
endfunction
nnoremap <silent> gs :set opfunc=Sort<CR>g@
" }}}

" Commands {{{
" Soft-wrap the text for copying into the text processors
command! -range=% SoftWrap
      \ <line2>put _ |
      \ <line1>,<line2>g/.\+/ .;-/^$/ join | normal $x

" Create or switch to the scratch buffer
command! Scratch
      \ e scratch |
      \ setlocal buftype=nofile bufhidden=hide noswapfile |
      \ nnoremap <silent> <buffer> ZZ :%y+<CR>ZQ
command! VScratch vs | Scratch
" }}}
" }}}

" Plugins {{{
lua << EOF
require 'config.plugins'
EOF

" filetype {{{
let g:did_load_filetypes = 1
" }}}

" vim-plug {{{
let g:plug_window = 'noautocmd tabnew'
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsListSnippets = '<s-tab>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = [stdpath('config') . '/snips']
" }}}

" NERDTree {{{
" Start NERDTree when Vim starts with a directory argument
autocmd settings StdinReadPre * let s:std_in=1
autocmd settings VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Close NERDTree when it is the last buffer
autocmd settings BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeWinSize = 30
let NERDTreeWinSizeMax = 50
let NERDTreeShowHidden = 1
let NERDTreeNaturalSort = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore = [ '\.git$' ]
let NERDTreeBookmarksFile = ''

nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFocus<CR>
nnoremap <silent> <leader>nF :NERDTreeFind<CR>
" }}}

" matchit.vim {{{
if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim
endif
" }}}

" vim-gitgutter {{{
" let g:gitgutter_map_keys = 0
" let g:gitgutter_show_msg_on_hunk_jumping = 0
" nmap ]c <Plug>(GitGutterNextHunk)
" nmap [c <Plug>(GitGutterPrevHunk)
" nmap <leader>gs <Plug>(GitGutterStageHunk)
" nmap <leader>gu <Plug>(GitGutterUndoHunk)
" nmap <leader>gp <Plug>(GitGutterPreviewHunk)
" }}}

" Fugitive {{{
nnoremap <silent> <leader>gg :Git<CR>
nnoremap <silent> <leader>gh :diffget //2<CR>
nnoremap <silent> <leader>gl :diffget //3<CR>
" }}}

" startify {{{
let g:startify_fortune_use_unicode = 1

let g:startify_files_number = 5

let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_change_cmd = 'tcd'

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                  },
      \ { 'type': 'commands',  'header': ['   Commands']                   },
      \ { 'type': 'files',     'header': ['   MRUs']                       },
      \ { 'type': 'dir',       'header': ['   MRUs in current directory '] },
      \ ]
let g:startify_bookmarks = [
      \ {'v': $MYVIMRC},
      \ {'m': $APPDATA . '\mpv\mpv.conf'},
      \ ]
let g:startify_commands = [
      \ {'s': ['Scratch', 'Scratch']},
      \ {'u': ['Update plugins', 'PlugUpgrade | PlugClean! | PlugUpdate']},
      \ {'h': ['Quick reference', 'h quickref']},
      \ ]
let g:startify_skiplist = [
      \ '\\\.git\\',
      \ 'runtime\\doc\\.*\.txt$',
      \ 'plugged\\.*\\doc\\.*\.txt$',
      \ ]
" }}}
" }}}

" General files settings {{{
augroup formatting
  autocmd!
  " Turn off automatic text wrapping (both text and comments)
  autocmd FileType * setlocal formatoptions-=tc
  " Turn off automatic comment insertion
  autocmd FileType * setlocal formatoptions-=ro
  " Preserve short lines and don't break words when formatting
  autocmd FileType * setlocal formatoptions+=w
  " Recognize numbered lists when formating
  autocmd FileType * setlocal formatoptions+=n
  " Don't break a line after a one-letter word when formatting
  autocmd FileType * setlocal formatoptions+=1
  " Remove comment leader when joining lines with comments
  autocmd FileType * setlocal formatoptions+=j
  " Don't break lines at single spaces that follow periods
  autocmd FileType * setlocal formatoptions+=p
augroup END

" LaTeX type
let g:tex_flavor = 'latex'
" }}}

" vim:fdm=marker:

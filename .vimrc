set nocompatible

if has("gui_running")
  set background=dark

  if has("gui_macvim")
    set guifont=Menlo:h13
  endif
else
  se background=light
  colo desert
endif



execute pathogen#infect()
syntax on
filetype plugin indent on


set cursorline
set splitright
set splitbelow

set t_Co=256
hi StatusLine ctermfg=black ctermbg=white
hi StatusLineNC ctermfg=black ctermbg=gray
hi VertSplit ctermfg=black ctermbg=gray
set fillchars=stl:_,stlnc:_,vert:\│

autocmd ColorScheme * highlight StatusLine ctermfg=black ctermbg=white
autocmd ColorScheme * highlight StatusLineNC ctermfg=black ctermbg=gray
autocmd ColorScheme * highlight VertSplit ctermfg=black ctermbg=gray

set et
set ai
set ts=2
set sw=2
set smarttab
set cinoptions+=j1
set cinwords+=try,except,finally,class
set syntax=on
set shiftround        " Always shift to a multiple of the shiftwidth.
inoremap # X#


nnoremap <F3> :set nu! nu?<CR>
imap <F3> <C-O><F3>
nnoremap <F11> :set paste! paste?<CR>
imap <F11> <C-O><F11>


map <F1> <ESC>
imap <F1> <ESC>


nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a
nnoremap <F12> :qa<CR>
nnoremap <F2> :w<CR>
nnoremap <Leader>q :q<CR>
imap <F2> <C-O><F2>


nnoremap , ;
nnoremap ; :


set ruler
set rulerformat=%18(L%l/%L,\ C%c%)


set history=1000                                " Command history.
" silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
set undolevels=1000                             " Undo history.
if version >= 703
  set undodir=~/.vim/undo
  set undofile
endif


set ff=unix
set visualbell
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.swp,*~,*.pyc,*.class
set wildmode=list:longest
set number
set showcmd                   " Show typed commands in the title bar.
set magic
set background=dark
set nobackup
set nowritebackup
set noshowmatch               " Auto brace-matching is distracting.
set lazyredraw                " No redraws in macros.


set isfname+==
set isfname+=<
set isfname+=>
set isfname+=;



nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

nmap J gJ

set hidden                    " Ok to leave modified buffers.
noremap <F6>  :n<Enter>
imap <F6> <C-O><F6>
noremap <F5>  :N<Enter>
imap <F5> <C-O><F5>
noremap <F10> :ls<CR>


set tags=./tags;              " Walk up the directory tree to look for tags.
noremap <F7> :ta
set is
set ignorecase
set smartcase
set sc
set hlsearch
set bs=eol,indent,start


if has("win32") || has("win64")
  set directory=$TMP
else
  " On Unix, explicitly set the shell to sh since vim assumes that the
  " shell is POSIX compliant by default. This assumption breaks if you are
  " using a non-POSIX compliant shell like fish.
  "
  set shell=sh

  " Create directory for swp files.
  "
  " silent !mkdir -p ~/usr/swp > /dev/null 2>&1
  set directory=~/usr/swp
end



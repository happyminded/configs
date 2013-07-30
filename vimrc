set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive' 
Bundle 'Syntastic'
Bundle 'Solarized'
Bundle 'Vim-R-plugin'
Bundle 'The-NERD-tree'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdcommenter'
Bundle 'PHP-correct-Indenting'
Bundle 'vim-php/phptags'
Bundle 'tpope/vim-surround'
Bundle 'tsaleh/vim-matchit'
Bundle 'joonty/vdebug'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/filetype.vim'
"Bundle 'brookhong/DBGPavim'
"Bundle 'ervandew/supertab'


" Appearance
set colorcolumn=80
filetype plugin indent on
set background=dark
colorscheme solarized
syntax on
set number
set guifont=Source\ Code\ Pro\ 10

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4


set backspace=indent,eol,start

" Back-up management
" --- verify if it works :)
if has("vcs")
    set nobackup
else
    set backup
endif

" Yanks go on clipboard instead. 
" - See more at: http://biodegradablegeek.com/vim-config/#sthash.JeYow3Mm.dpuf
set clipboard+=unnamed  

" prevent vim from littering directories with swap and ~ files
" tell vim where to put its backup files
set backupdir=~/vim_tmp

" tell vim where to put swap files
set dir=~/vim_tmp


set history=256
set ruler
set showcmd

" A common operation is to search for text, so it makes sense to have some 
" sane defaults. The incsearch option highlights as you type an expression 
" (a.k.a. “Emacs style”), and ignorecase plus smartcase make searches 
" case-insensitive except when you include upper-case characters 
" (so /foo matches FOO and fOo, but /FOO only matches the former). 
" hlsearch is a useful option which highlights the current search, 
" but the highlight can become annoying so it makes sense to have a key 
" to clear the highlight when you no longer need it:
set incsearch
set ignorecase
set smartcase
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
nmap \q :nohlsearch<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,       
" so that you can undo CTRL-U after inserting a line break.                     
inoremap <C-U> <C-G>u<C-U>  

if has('mouse')
    set mouse=a
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Who uses ',' in vim, anyway? :)
let g:mapleader=','

" Natural navigation in wrapped lines
nnoremap j gj
nnoremap k gk

""" Buffers
" Reopen the last file in buffer; use :b# if funny things start to happen
" nmap <C-e> :e#<CR> 
" cycle between all open buffers:
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" ctrlp plugin remappings 
nmap ; :CtrlPBuffer<CR>

" NerdTREE toggle
nmap \e :NERDTreeToggle<CR>

" TagList related
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<CR>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Powerline options
let g:Powerline_symbols = 'unicode'

" switch line wrapping
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

" CtrlP plugin mappings
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" smooth scroll
function SmoothScroll(up)
    if a:up
        let scrollaction=""
    else
        let scrollaction=""
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i


" html indentation
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType phtml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4


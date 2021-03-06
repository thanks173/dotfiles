" Better safe than sorry
set nocompatible

" -------- General Settings --------
set number
set incsearch
set hlsearch
set clipboard=unnamedplus
set autoread
set autowrite
set background=dark
set t_Co=256
set nobackup
set nowb
set noswapfile
set backupdir=~/tmp,/tmp
set backupcopy=yes
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=/tmp
" Disable the preview window popping up
set completeopt-=preview

syntax on
filetype plugin indent on

" -------- Indenting --------
set autoindent
set si "smart indent
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" -------- Auto Install VimPlug --------
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
	!sudo apt update
	!sudo apt install build-essential cmake python3-dev -y
	!python3 ./install.py --all
endfunction

function! InstallNerdFonts(info)
	!mkdir -p ~/.local/share/fonts
	!cd ~/.local/share/fonts && wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid Sans Mono Nerd Font Complete.otf"
endfunction

call plug#begin('~/.vim/plugged')
" Utility
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'benmills/vimux'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Programming Support
Plug 'valloric/youcompleteme', { 'do': function('BuildYCM') }
Plug 'raimondi/delimitmate'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mattn/emmet-vim'
" Git Support
Plug 'airblade/vim-gitgutter'
" Theme / Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons', { 'do': function('InstallNerdFonts') }
call plug#end()

" -------- Key Mapping --------
cmap w!! w !sudo tee > /dev/null %
map <F8> :TagbarToggle<CR>
map <C-n> <plug>NERDTreeTabsToggle<CR>

" -------- YouCompleteMe Settings --------
let g:ycm_show_diagnostics_ui = 0
let g:ycm_add_preview_to_completeopt = 0

" -------- Syntastic Settings --------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_auto_jump = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" -------- Customize VimAirline --------
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

" -------- Customize Coding Plugin --------
let g:go_template_autocreate = 0

" -------- Customize NERDTree Plugin --------
let NERDTreeShowHidden=1

" ███████╗ █████╗ ███╗   ██╗███████╗██╗   ██╗███████╗
" ╚══███╔╝██╔══██╗████╗  ██║██╔════╝╚██╗ ██╔╝██╔════╝
"   ███╔╝ ███████║██╔██╗ ██║█████╗   ╚████╔╝ ███████╗
"  ███╔╝  ██╔══██║██║╚██╗██║██╔══╝    ╚██╔╝  ╚════██║
" ███████╗██║  ██║██║ ╚████║███████╗   ██║   ███████║
" ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚══════╝
" Dotfiles circa 2023 (Inspired by DT's config)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Automatically install vim-plug node & language servers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  autocmd VimEnter * CocInstall coc-sh coc-clangd coc-html coc-tsserver coc-json coc-pyright coc-go coc-css coc-rust-analyzer
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'itchyny/lightline.vim'                       " Lightline statusbar
    Plug 'scrooloose/nerdtree'                         " Nerdtree
    Plug 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
    Plug 'dracula/vim', { 'as': 'dracula' }            " Dracula Color Scheme
    Plug 'tpope/vim-surround'                          " Change surrounding marks
    Plug 'PotatoesMaster/i3-vim-syntax'                " i3 config highlighting
    Plug 'kovetskiy/sxhkd-vim'                         " sxhkd highlighting
    Plug 'vim-python/python-syntax'                    " Python highlighting
    Plug 'ap/vim-css-color'                            " Color previews for CSS
    Plug 'junegunn/vim-emoji'                          " Vim needs emojis!
    Plug 'https://github.com/tpope/vim-commentary'     " Comment Out With gcc & Uncomment With gcgc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    " Code Completion (requires node)
    Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
    Plug 'ghifarit53/tokyonight-vim'                   " Tokyo Night Theme
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**					" Searches current directory recursively.
set wildmenu					" Display all matches when tab complete.
set incsearch                   " Incremental search
set hidden                      " Needed to keep multiple buffers open
set nobackup                    " No auto backups
set noswapfile                  " No swap
set t_Co=256                    " Set if term supports 256 colors.
set number                      " Display line numbers
set clipboard=unnamedplus       " Copy/paste between vim and other programs.
syntax enable                   " Enable syntax highlighting
set nocompatible                " Be iMproved, required
filetype plugin indent on       " Required
set mouse=a                     " Required
set encoding=UTF-8              " Set encoding
let NERDTreeShowHidden=1        " NERDtree shows hidden files
set term=kitty                  " fix for kitty terminal
" colorscheme dracula             " Dracula Color Scheme
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
" get transparent bg & some markdown stuffs
highlight Normal guibg=NONE ctermbg=NONE
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap ESC to ii
:imap ii <Esc>
" Ctrl + f opens and closes NERDtree
nnoremap <C-f>		:NERDTreeToggle<CR>
" Enter selects completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Use Tab to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
" Always show statusline
set laststatus=2
" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lines to save text folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWinLeave *.* mkview 
autocmd BufWinEnter *.* silent loadview

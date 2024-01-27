{ pkgs, config, ... }:

{
  home.file.".vimrc".text = ''
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
        Plug 'scrooloose/nerdtree'                         " Nerdtree
        Plug 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
        Plug 'tpope/vim-surround'                          " Change surrounding marks
        Plug 'PotatoesMaster/i3-vim-syntax'                " i3 config highlighting
        Plug 'kovetskiy/sxhkd-vim'                         " sxhkd highlighting
        Plug 'vim-python/python-syntax'                    " Python highlighting
        Plug 'ap/vim-css-color'                            " Color previews for CSS
        Plug 'junegunn/vim-emoji'                          " Vim needs emojis!
        Plug 'https://github.com/tpope/vim-commentary'     " Comment Out With gcc & Uncomment With gcgc
        Plug 'neoclide/coc.nvim', {'branch': 'release'}    " Code Completion (requires node)
        Plug 'LnL7/vim-nix'                                " Nix highlighting and detection
        Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
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
    set termguicolors

    " Theme System & Ensure Transparency works
    hi Normal           guibg=NONE      ctermbg=NONE
    :source $HOME/.vimcolors.vim

    " Markdown Stuffs
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
    " Always show statusline
    set laststatus=2
    " Uncomment to prevent non-normal modes showing in powerline and below powerline.
    set noshowmode

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Lines to save text folding
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    autocmd BufWinLeave *.* mkview 
    autocmd BufWinEnter *.* silent loadview
  '';

  home.file.".vimcolors.vim".text = ''
    hi clear
    syntax reset
    let g:colors_name = "sunset"
    set background=dark
    set t_Co=256
    hi Normal guifg=#${config.colorScheme.colors.base05} ctermbg=NONE guibg=NONE gui=NONE

    hi DiffText guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi ErrorMsg guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi WarningMsg guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi PreProc guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi Exception guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi Error guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi DiffDelete guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi GitGutterDelete guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi GitGutterChangeDelete guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi cssIdentifier guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi cssImportant guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi Type guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi Identifier guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi PMenuSel guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi Constant guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi Repeat guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi DiffAdd guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi GitGutterAdd guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi cssIncludeKeyword guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi Keyword guifg=#${config.colorScheme.colors.base0B} guibg=NONE
    hi IncSearch guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Title guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi PreCondit guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Debug guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi SpecialChar guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Conditional guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Todo guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Special guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Label guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Delimiter guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Number guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi CursorLineNR guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Define guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi MoreMsg guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Tag guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi String guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi MatchParen guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Macro guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi DiffChange guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi GitGutterChange guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi cssColor guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Function guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi Directory guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi markdownLinkText guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi javaScriptBoolean guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi Include guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi Storage guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi cssClassName guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi cssClassNameDot guifg=#${config.colorScheme.colors.base09} guibg=NONE
    hi Statement guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi Operator guifg=#${config.colorScheme.colors.base0C} guibg=NONE
    hi cssAttr guifg=#${config.colorScheme.colors.base0C} guibg=NONE


    hi Pmenu guifg=#${config.colorScheme.colors.base05} guibg=#${config.colorScheme.colors.base0D}
    hi Title guifg=#${config.colorScheme.colors.base05}
    hi LineNr guifg=#${config.colorScheme.colors.base0A} guibg=NONE
    hi NonText guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Comment guifg=#${config.colorScheme.colors.base03} gui=italic
    hi SpecialComment guifg=#${config.colorScheme.colors.base03} gui=italic guibg=NONE
    hi CursorLine guibg=#${config.colorScheme.colors.base0D}
    hi TabLineFill gui=NONE guibg=#${config.colorScheme.colors.base00}
    hi TabLine guifg=#${config.colorScheme.colors.base05} guibg=#${config.colorScheme.colors.base00} gui=NONE
    hi StatusLine gui=bold guibg=#${config.colorScheme.colors.base0D} guifg=#${config.colorScheme.colors.base01}
    hi StatusLineNC gui=NONE guibg=NONE guifg=#${config.colorScheme.colors.base05}
    hi Search guibg=#${config.colorScheme.colors.base03} guifg=#${config.colorScheme.colors.base05}
    hi VertSplit gui=NONE guifg=#${config.colorScheme.colors.base0D} guibg=NONE
    hi Visual gui=NONE guibg=#${config.colorScheme.colors.base0D}
  '';
}

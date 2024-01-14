{ pkgs, config, ... }:

{
  home.file.".vimcolors.vim".text = ''
    hi clear
    syntax reset
    let g:colors_name = "dynamiccolors"
    set background=dark
    set t_Co=256
    hi Normal guifg=#${config.colorScheme.colors.base07} ctermbg=NONE guibg=#${config.colorScheme.colors.base00} gui=NONE

    hi DiffText guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi ErrorMsg guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi WarningMsg guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi PreProc guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi Exception guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi Error guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi DiffDelete guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi GitGutterDelete guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi GitGutterChangeDelete guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi cssIdentifier guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi cssImportant guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi Type guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi Identifier guifg=#${config.colorScheme.colors.base01} guibg=NONE
    hi PMenuSel guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi Constant guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi Repeat guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi DiffAdd guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi GitGutterAdd guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi cssIncludeKeyword guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi Keyword guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi IncSearch guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Title guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi PreCondit guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Debug guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi SpecialChar guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Conditional guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Todo guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Special guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Label guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Delimiter guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Number guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi CursorLineNR guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Define guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi MoreMsg guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Tag guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi String guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi MatchParen guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Macro guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi DiffChange guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi GitGutterChange guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi cssColor guifg=#${config.colorScheme.colors.base03} guibg=NONE
    hi Function guifg=#${config.colorScheme.colors.base04} guibg=NONE
    hi Directory guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi markdownLinkText guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi javaScriptBoolean guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi Include guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi Storage guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi cssClassName guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi cssClassNameDot guifg=#${config.colorScheme.colors.base05} guibg=NONE
    hi Statement guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi Operator guifg=#${config.colorScheme.colors.base06} guibg=NONE
    hi cssAttr guifg=#${config.colorScheme.colors.base06} guibg=NONE


    hi Pmenu guifg=#${config.colorScheme.colors.base0F} guibg=#${config.colorScheme.colors.base08}
    hi SignColumn guibg=#${config.colorScheme.colors.base00}
    hi Title guifg=#${config.colorScheme.colors.base06}
    hi LineNr guifg=#${config.colorScheme.colors.base07} guibg=#${config.colorScheme.colors.base00}
    hi NonText guifg=#${config.colorScheme.colors.base05} guibg=#${config.colorScheme.colors.base00}
    hi Comment guifg=#${config.colorScheme.colors.base05} gui=italic
    hi SpecialComment guifg=#${config.colorScheme.colors.base05} gui=italic guibg=NONE
    hi CursorLine guibg=#${config.colorScheme.colors.base08}
    hi TabLineFill gui=NONE guibg=#${config.colorScheme.colors.base08}
    hi TabLine guifg=#${config.colorScheme.colors.base07} guibg=#${config.colorScheme.colors.base08} gui=NONE
    hi StatusLine gui=bold guibg=#${config.colorScheme.colors.base08} guifg=#${config.colorScheme.colors.base0F}
    hi StatusLineNC gui=NONE guibg=#${config.colorScheme.colors.base00} guifg=#${config.colorScheme.colors.base0F}
    hi Search guibg=#${config.colorScheme.colors.base05} guifg=#${config.colorScheme.colors.base0F}
    hi VertSplit gui=NONE guifg=#${config.colorScheme.colors.base08} guibg=NONE
    hi Visual gui=NONE guibg=#${config.colorScheme.colors.base08}
  '';
}

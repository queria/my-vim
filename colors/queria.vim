" Vim color file
" Maintainer: Queria Sa-Tas <queria@sa-tas.net>
" Last Change:	2010-06-28
" Based on 'torte' colorscheme by	Thorsten Maerz <info@netztorte.de>
" optimized for dark(transparent) background
" vim: set et sw=4 ts=4:

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
colorscheme torte 
let g:colors_name = "queria"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
highlight Normal     guifg=Grey80   guibg=Black
highlight Search     guifg=Black    guibg=Red   gui=bold
highlight Visual     guifg=#404040              gui=bold
highlight Cursor     guifg=Black    guibg=Green gui=bold
highlight Special    guifg=Orange
highlight Comment    guifg=#80a0ff
highlight StatusLine gui=bold       guifg=Black guibg=White
highlight StatusLineNC gui=NONE     guifg=Black guibg=White
highlight Statement  guifg=#ffff54              gui=NONE
highlight Type                                  gui=NONE
highlight PMenuSel   guifg=Black    guibg=Yellow

" Console
highlight Normal                        ctermfg=LightGrey
highlight Search     cterm=NONE         ctermfg=Black      ctermbg=Red
highlight Visual     cterm=reverse
highlight Cursor     cterm=bold         ctermfg=Black   ctermbg=Green
highlight Special                       ctermfg=Brown
highlight Comment    cterm=NONE         ctermfg=DarkMagenta
highlight StatusLine cterm=bold         ctermfg=White   ctermbg=Black
highlight StatusLineNC cterm=NONE       ctermfg=White   ctermbg=Black
highlight Statement  cterm=NONE         ctermfg=Yellow
highlight Type       cterm=NONE

highlight Search     ctermfg=Black      ctermbg=DarkYellow  cterm=none
highlight IncSearch  ctermfg=Black      ctermbg=Yellow  cterm=none
"highlight 
highlight CursorLine ctermfg=NONE       ctermbg=NONE    cterm=underline
highlight Visual     term=reverse       ctermbg=0       cterm=reverse
highlight Ignore     ctermfg=DarkGray
highlight PMenuSel   ctermfg=Black      ctermbg=Yellow

highlight Folded     ctermfg=Gray       ctermbg=NONE
" highlight FoldColumn     xxx term=standout ctermfg=14 ctermbg=82 guifg=Cyan guibg=Grey

highlight DiffText   cterm=NONE         ctermfg=White   ctermbg=DarkBlue
highlight DiffChange cterm=NONE ctermbg=DarkBlue  ctermfg=Black
highlight DiffAdd    cterm=NONE         ctermfg=White   ctermbg=DarkGreen
highlight DiffDelete cterm=NONE         ctermfg=White   ctermbg=DarkRed
"ctermfg=Black   ctermbg=White

highlight ColorColumn cterm=bold ctermbg=none ctermfg=none

" only for vim 5
if has("unix")
  if v:version<600
    highlight Normal  ctermfg=Grey	ctermbg=Black	cterm=NONE	guifg=Grey80      guibg=Black gui=None
    highlight Search  ctermfg=Black	ctermbg=Red	cterm=bold	guifg=Black       guibg=Red	gui=bold
    highlight Visual  ctermfg=Black	ctermbg=yellow	cterm=bold	guifg=#404040			gui=bold
    highlight Special ctermfg=LightBlue			cterm=NONE	guifg=LightBlue			gui=NONE
    highlight Comment ctermfg=Cyan			cterm=NONE	guifg=LightBlue			gui=NONE
  endif
endif


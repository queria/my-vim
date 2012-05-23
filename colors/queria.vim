" Vim color file
" Maintainer: Queria Sa-Tas <queria@sa-tas.net>
" Last Change:	2010-06-28
" Based on 'torte' colorscheme by	Thorsten Maerz <info@netztorte.de>
" optimized for dark(transparent) background

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
highlight Normal     guifg=Grey80
highlight Search     guifg=Black	guibg=Red	gui=bold
highlight Visual     guifg=#404040			gui=bold
highlight Cursor     guifg=Black	guibg=Green	gui=bold
highlight Special    guifg=Orange
highlight Comment    guifg=#80a0ff
highlight StatusLine guifg=blue		guibg=white
highlight Statement  guifg=Yellow			gui=NONE
highlight Type						gui=NONE

" Console
highlight Normal     ctermfg=LightGrey
highlight Search     ctermfg=Black	ctermbg=Red	cterm=NONE
highlight Visual					cterm=reverse
highlight Cursor     ctermfg=Black	ctermbg=Green	cterm=bold
highlight Special    ctermfg=Brown
highlight Comment    ctermfg=Grey
highlight StatusLine ctermfg=blue	ctermbg=white
highlight Statement  ctermfg=Yellow			cterm=NONE
highlight Type						cterm=NONE

highlight Search ctermfg=Black ctermbg=Yellow cterm=none
highlight IncSearch  ctermfg=Black ctermbg=Yellow cterm=none
"highlight 
highlight CursorLine cterm=underline ctermbg=NONE ctermfg=NONE
highlight Visual term=reverse cterm=reverse ctermbg=0
highlight Ignore ctermfg=DarkGray
highlight PMenuSel ctermfg=Black ctermbg=Yellow guibg=Yellow

highlight Folded ctermbg=NONE
" highlight FoldColumn     xxx term=standout ctermfg=14 ctermbg=82 guifg=Cyan guibg=Grey

" only for vim 5
if has("unix")
  if v:version<600
    highlight Normal  ctermfg=Grey	ctermbg=Black	cterm=NONE	guifg=Grey80      guibg=Black	gui=NONE
    highlight Search  ctermfg=Black	ctermbg=Red	cterm=bold	guifg=Black       guibg=Red	gui=bold
    highlight Visual  ctermfg=Black	ctermbg=yellow	cterm=bold	guifg=#404040			gui=bold
    highlight Special ctermfg=LightBlue			cterm=NONE	guifg=LightBlue			gui=NONE
    highlight Comment ctermfg=Cyan			cterm=NONE	guifg=LightBlue			gui=NONE
  endif
endif


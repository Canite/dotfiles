" Vim syntax file
" Language:     Note files for school
" Maintainer:   Austin Ross
" Last Change:  March 31, 2014
" Version:      1
"
if exists("b:current_syntax")
  finish
endif

syn region aDate start=/^-/ end=/$/
syn region subTitle start=/^|/ end=/$/
syn match section '[IVXML][IVXML]*\.'
syn match comment '#.*$'
syn region block start="{" end="}" fold transparent
syn match blueKeywords 'Q[0-9][0-9]*:'
syn match greenKeywords 'Answer:'


"hi def link aTitle Comment
hi def link comment Comment
highlight aDate cterm = bold cterm=underline
highlight subTitle cterm = bold ctermfg = black ctermbg = cyan
highlight section ctermfg = red
highlight greenKeywords ctermfg = green
highlight blueKeywords ctermfg = blue

let b:current_syntax = "note"

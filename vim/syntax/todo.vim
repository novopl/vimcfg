" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match Underlined 	/-> .*/ 	contained
syn match Comment 	/^[+]\+ .*/ 	contains=Underlined
syn match SpecialKey 	/^[*]\+ .*/

let b:current_syntax = "todo"

" vim: ts=8 sw=2

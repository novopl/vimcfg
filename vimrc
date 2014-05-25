
call pathogen#infect()
call pathogen#helptags()
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

filetype off
syntax on
filetype plugin indent on


""""""""""""""
"  Settings  "
""""""""""""""


colorscheme molokai-novo
let &colorcolumn="80,81"

" Indents
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
" Mouse
set mouse=a
set mousef
" Folding
set foldenable
set foldmethod=marker
set foldcolumn=1
set foldnestmax=10
set foldlevel=1
" Misc
set completeopt=menuone,longest,preview
set encoding=utf-8
let mapleader = ","
set hlsearch
set number


"""""""""""""""""""""""""""
"  Plugins configuration  "
"""""""""""""""""""""""""""


let g:gitgutter_sign_column_always=1
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:utlisnips_python_style='sphinx'
"let g:jedi#use_tabs_not_buffers=0
let g:pydiction_location='~/.vim/bundle/pydyction/complete-dict'
let g:syntastic_python_checkers=['flake8']
" E265 - require comment to start with '# '
" E221 - Multiple spaces before the operator
" E241 - Multiple spaces after :
" E251 - Unexpected spaces around keyword / parameter equals 
" E271 - Multiple spaces after keyword
" E272 - Multiple spaces before keyword
" E702 - Multiple statements on one line
" W391 - Blank line at the end of file
" F821 - Undefined name
let g:syntastic_python_flake8_args='--ignore=E265,E221,E241,E251,E702,W391,F821'
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:tagbar_width=36
let g:tagbar_singlelick=1
let g:tagbar_sort=0
let g:tagbar_compact=1
let g:tagbar_autofocus=1
let g:tagbar_autoclose=1
let NERDTreeWinSize=24
let NERDTreeIgnore=['swp', '\~$', 'kdev4$', '\.pyc$']
let NERDTreeMouseMode=2
let g:toggle_list_no_mappings=1

" gvim
if has("gui_running")
  set guifont=Monospace\ 7
endif


""""""""""""""
"  Mappings  "
""""""""""""""


let Tlist_Use_Right_Window = 1
map <F1>  :!docbuild<CR>
map <F2>    :NERDTreeToggle<CR>
map <F3>    :TagbarToggle<CR>
map <Leader>nt      :call TODO_add()<CR>
map <Leader>vt      :tabnew TODO<CR>
"map <Leader>dt      :call TODO_done()<CR>
map <Leader>dt      ^r+
map <Leader>ct      :call TODO_clear_complete()<CR>
map <Leader>find    :call SearchProject()<CR>
map <Leader>a       :call SearchProject()<CR>
" Shortcuts
map <Leader>v       :vsp<CR>
map <Leader>s       :shell<CR>
map <Leader>wrap    :set textwidth=80<CR>
map <Leader>nowrap  :set textwidth=0<CR>
" Quick fixes
map <Leader>isk :set iskeyword=@,48-57,_,192-255
map <Leader>fix :call FixTabs()<CR>
" Git mappings
map <Leader>c       :call ToggleQuickfixList()<CR>
map <Leader>w       :wa<CR>
map <Leader>gl      :Glog<CR>:cw<CR>
map <Leader>Gl      :Glog --<CR>:cw<CR>
map <Leader>gs      :Gstatus<CR>
map <Leader>gd      :Gdiff<CR>
map <Leader>ge      :Gedit<CR>
map <Leader>gpush   :Git push<CR>
map <Leader>gpull   :Git pull<CR>
map <Leader>qg      :!qgit4<CR><CR>
map <Leader>nu      :windo call ToggleNumbers()<CR>
map <Leader>gpush   :!git push<CR>
map <Leader>l       gt
noremap <S-t>       gT
" View switching
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" Window movement
nnoremap <A-.> :call MoveToNextTab()<CR>
nnoremap <A-,> :call MoveToPrevTab()<CR>
" ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

fu! ToggleNumbers() "{{{
  if getwinvar( winnr(), '&modifiable' )
    set nu!
  endif
endfunction
"}}}

fu! SearchProject() "{{{
  let regexp=input("Search project: ")
  execute "Ggrep ".l:regexp
  lw
endfu
"}}}


"-----------------------------------------------------------------------------//
fu! TODO_add()
  let todo=input("TODO: ")
  if !empty(todo)
    let todo='- '.todo

    if filereadable('TODO')
      let fcontents=readfile('TODO', 'b')
      if !empty(fcontents) && empty(fcontents[-1])
        call remove(fcontents, -1)
      endif
      let lines = fcontents+[todo]
    else
      let lines = [todo]
    endif

    call writefile(lines, 'TODO', 'b')
  endif
endfu

"-----------------------------------------------------------------------------//
fu! TODO_done()
  execute('^r+w')
endfunction

"-----------------------------------------------------------------------------//
fu! TODO_clear_complete()
python << EOF
import vim
from os.path import basename

fileName = basename(vim.current.buffer.name)
if fileName == 'TODO':
  iscompl   = lambda l: l.strip().startswith('+')
  toRemove  = [i for i,l in enumerate(vim.current.buffer) if iscompl(l)]
  for i in reversed(toRemove):
    del vim.current.buffer[i]
  print('Completed items have been removed')
else:
  print('{0} is not a TODO. Aborting.'.format(fileName))

EOF
  w
endfunction

"-----------------------------------------------------------------------------//
fu! FixTabs()
  let l:width=input("Tab width: ")
  execute "set shiftwidth=".l:width
  execute "set tabstop=".l:width
  execute "set softtabstop=".l:width
endfunction

"-----------------------------------------------------------------------------//
fu! LoadLocal()
  echo "Checking for local settings"
  if filereadable( "local.vim" )
    source local.vim
  endif
endfunction


""""""""""""""""""
"  Autocommands  "
""""""""""""""""""


au BufReadPost * :call CustomModeLine("vimex:")

" Change colorcolumn for python files (to conform with pep8)
au FileType python let &colorcolumn="80,81"


" Closetag only on markup languages
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" Remove docstring preview on completion
autocmd FileType * setlocal completeopt-=preview

" Save view for folding
au BufWinLeave * mkview
au BufWinEnter *.* silent loadview

" Detect environment
au VimEnter * :call LoadLocal()

" Highlight extra whitespace at the end of the line
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red



"-----------------------------------------------------------------------------//
" BIES MAKRO
function! CustomModeLine(cid)
	let i = &modelines
	let lln = line("$")
	if i > lln | let i = lln | endif
	while i>0
		let l = getline(lln-i+1)
		if l =~ a:cid
			exec strpart(l, stridx(l, a:cid)+strlen(a:cid))
		endif
		let i = i-1
	endwhile
endfunction
"}}}



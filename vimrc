
call pathogen#infect()
call pathogen#helptags()

filetype off
syntax on
filetype plugin indent on

"{{{ Settings
colorscheme molokai-novo
" Indents
set tabstop=2
set shiftwidth=2
set softtabstop=2
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
"}}}

"{{{ Plugin conf
let g:jedi#use_tabs_not_buffers=0
let g:pydiction_location='~/.vim/bundle/pydyction/complete-dict'
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
"}}}

"{{{ gvim
if has("gui_running")
  set guifont=Monospace\ 7
endif
"}}}

"{{{ Mapping
let Tlist_Use_Right_Window = 1
map <F1>  :!docbuild<CR>
map <F2>  :NERDTreeToggle<CR>
map <F3>  :TagbarToggle<CR>
map <F10> :qa<CR>
" Shortcuts
map <Leader>l   :TagbarToggle<Cr>
map <Leader>v   :vsp<CR>
map <Leader>s   :shell<CR>
" Quick fixes
map <Leader>isk :set iskeyword=@,48-57,_,192-255
map <Leader>fix :call FixTabs()<CR>
" Folding
nnoremap <Leader>f  za 
nnoremap <Leader>F  zA 
" Git mappings
map <Leader>c       :call ToggleQuickfixList()<CR>
map <Leader>w       :wa<CR>
map <Leader>gl      :Glog<CR>:cw<CR>
map <Leader>Gl      :Glog --<CR>:cw<CR>
map <Leader>gs      :Gstatus<CR>
map <Leader>gw      :Gwrite<CR>
map <Leader>gr      :Gread<CR>
map <Leader>gd      :Gdiff<CR>
map <Leader>ge      :Gedit<CR>
map <Leader>gpush   :Git push<CR>
map <Leader>gpull   :Git pull<CR>
map <Leader>qg      :!qgit4<CR><CR>
map <Leader>nu      :windo call ToggleNumbers()<CR>
map <Leader>gcommit :!git commit<CR>
map <Leader>gpush   :!git push<CR>
" View switching
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" Window movement
nnoremap <A-.> :call MoveToNextTab()<CR>
nnoremap <A-,> :call MoveToPrevTab()<CR>
" Switch between different environments
noremap <Leader>nw :call SetEnv_nweb()<CR>
noremap <Leader>an :call SetEnv_android()<CR>
noremap <Leader>uc :call SetEnv_arduino()<CR>
noremap <Leader>py :call SetEnv_python()<CR>
" ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"}}}

"{{{ Android related functions
:fu! Android_proj_build()
  :!ant debug
:endfunction
:fu! Android_proj_upload()
  :!adb install -r bin/*-debug.apk
:endfunction
:fu! Android_proj_log()
  :!adb shell logcat | grep "^[IVDE]/$(basename $(pwd))"
:endfunction
"}}}

fu! ToggleNumbers() "{{{
  if getwinvar( winnr(), '&modifiable' )
    set nu!
  endif
endfunction
"}}}

fu! FixTabs() "{{{
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2
endfunction
"}}}

"{{{ Sessions
"set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,resize,tabpages,winsize,winpos
"set sessionoptions-=options
"}}}

"{{{ Autocommands
au BufReadPost * :call CustomModeLine("vimex:")

" Closetag only on markup languages
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
" Remove docstring preview on completion
autocmd FileType * setlocal completeopt-=preview
" Save view for folding
au BufWinLeave * mkview
au BufWinEnter *.* silent loadview
" Detect environment
au VimEnter * :call Env_nweb_detect()
au VimEnter * :call Env_cmake_detect()
au VimEnter * :call Env_local_detect()

" Highlight extra whitespace at the end of the line
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
"}}}

"{{{ BIES MAKRO
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

"{{{ ENVIRONMENTS

" Android environment
:fu! SetEnv_android()
  :noremap <F5> :call Android_proj_build()<CR>
  :noremap <F6> :call Android_proj_upload()<CR>
  :noremap <F7> :call Android_proj_log()<CR>
  :echo "Android environment"
:endfunction

" Arduino environment
:fu! SetEnv_arduino()
  :noremap <F5> :make<CR>
  :noremap <F6> :make upload<CR>
  :noremap <F7> :!arduino-serial-mon<CR>
  autocmd! BufNewFile,BufRead *.cpp setlocal ft=arduino
  :echo "Arduino environment"
:endfunction

" C++ environment
fu! SetEnv_cpp()
  map <F4> :!make -j4 -C build -s clean<CR>
  map <F5> :!make -j4 -C build -s<CR>
endfunction

fu! Env_cmake_bootstrap()
  map <F5> :!make -j4 -C build -s<CR>
  map <S-F5> :!make -j4 -C build -s clean<CR>
  echo "cmake environment"
endfunction

fu! Env_cmake_detect()
 if filereadable( glob("CMakeLists.txt") )
   call Env_cmake_bootstrap()
 endif
endfunction

" Python environment
 :fu! SetEnv_python()
" Find a way to get the name of the module to call. It should
" be the name of the parent directory with .py extension
    :nnoremap <F5> :!./app.py<CR>
    :nnoremap <F8> :!./main.py<CR>
    :au BufRead *.py :set iskeyword=@,48-57,_,192-255
    :echo "Python environment"
 :endfunction


" nweb environment

" Bootstrap nweb environtment
function! Env_nweb_bootstrap()
  let g:pydiction_location='~/.vim/pydyction-dict'
  au BufRead *.py :set iskeyword=@,48-57,_,192-255
  noremap <F5> :!nwman collect<CR>
  noremap <F6> :!nwman test<CR>
  echo "nweb environment"
endfunction

function! Env_nweb_detect()
  echo "Checking for nweb"
  if filereadable( glob("*.nwman") )
    call Env_nweb_bootstrap()
  endif
endfunction

" local environment
function! Env_local_detect()
  echo "Checking for local settings"
  if filereadable( "local.vim" )
    source local.vim
  endif
endfunction

"}}}

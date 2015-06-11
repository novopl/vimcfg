
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
"set nowrap
set hlsearch
set cryptmethod=blowfish
set number
set relativenumber


"""""""""""""""""""""""""""
"  Plugins configuration  "
"""""""""""""""""""""""""""
" E124 - closing bracket does not match visual indentation
" E265 - require comment to start with '# '
" E221 - Multiple spaces before the operator
" E241 - Multiple spaces after :
" E251 - Unexpected spaces around keyword / parameter equals 
" E271 - Multiple spaces after keyword
" E272 - Multiple spaces before keyword
" E702 - Multiple statements on one line
" E731 - Do not assign to lambda expression, use def
" W391 - Blank line at the end of file
" F821 - Undefined name
" F403 - 'from XXX import *' used; cannot detect undefined names
let g:pep8_ignore=[
\   'E124',
\   'E221',
\   'E241',
\   'E251',
\   'E265',
\   'E272',
\   'E702',
\   'W391',
\   'F821',
\   'F403',
\   'E731'
\]




"----------------------------------------------------------------------------//
" UltiSnips
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:utlisnips_python_style='sphinx'
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"

"----------------------------------------------------------------------------//
" jedi-vim
"let g:jedi#use_tabs_not_buffers=0
"let g:jedi#show_call_signatures=0
"let g:jedi#force_py_version=2
"let g:jedi#popup_select_first=1
"let g:jedi#popup_on_dot=0

"----------------------------------------------------------------------------//
" YouCompleteMe
" Populate loclist every time ne diagnostics come in
" Use CWD instead of buffer(file) related path completer
"----------------------------------------------------------------------------//
let g:ycm_min_num_identifier_candidate_chars=3
let g:ycm_complete_in_comments=1
let g:ycm_always_populate_location_list = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_confirm_extra_conf=0

"----------------------------------------------------------------------------//
" python-mode
let g:pymode_rope_completion=0
let g:pymode_rope_comple_on_dot=0
let g:pymode_breakpoint=1
let g:pymode_lint_ignore=join(g:pep8_ignore, ',')
let g:pymode_lint_cwindow=0
let g:pymode_folding=0
let g:pymode_syntax_docstrings=0
"let g:pymode_syntax_highlight_self=0

"----------------------------------------------------------------------------//
" TagBar
let g:tagbar_width=36
let g:tagbar_singlelick=1
let g:tagbar_sort=0
let g:tagbar_compact=1
let g:tagbar_autofocus=1
let g:tagbar_autoclose=0

"----------------------------------------------------------------------------//
" NERDTree
let NERDTreeWinSize=30
let NERDTreeIgnore=['swp', '\~$', 'kdev4$', '\.pyc$']
let NERDTreeMouseMode=2

"----------------------------------------------------------------------------//
" Other
let g:SuperTabDefaultCompletionType="context"
let g:gitgutter_sign_column_always=1
let g:gitgutter_signs=0
let g:acp_ignorecaseOption=0
let g:pydiction_location='~/.vim/bundle/pydyction/complete-dict'
let g:pyflakes_use_quickfix=0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore='.join(g:pep8_ignore, ',')
"let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:toggle_list_no_mappings=1

" gvim
if has("gui_running")
    set guifont=Inconsolata\ 9
    set guioptions-=T
    set guioptions-=m
endif



""""""""""""""
"  Mappings  "
""""""""""""""


let Tlist_Use_Right_Window = 1
map <F2>    :NERDTreeToggle<CR>
map <F3>    :TagbarToggle<CR>
map <F11>   :CommandTFlush<CR>
map <S-F11>   :CommandTFlush<CR>
map <F12>   :so ~/.vimrc<CR>
map <C-s>   :wa<CR>
map <M-LeftMouse>   *@:call pymode#rope#goto_definition()<CR>
map <C-LeftMouse>   *@:call pymode#rope#goto_definition()<CR>
"map <Leader>dt      :call TODO_done()<CR>
"map <Leader>ct      :call TODO_clear_complete()<CR>
map <Leader>find    :call SearchProject()<CR>
map <Leader>fix     :call FixTabs()<CR>
map <Leader>f=      :call FormatAssignment()<CR>
map <Leader>fw      :call FormatFillWidth()<CR>
map <Leader>a       :call SearchProject()<CR>

map <Leader>vs      :vsp<CR>
"map <Leader>vt      :tabnew TODO<CR>
map <Leader>sh      :shell<CR>
map <Leader>wr      :call ChangeWrap()<CR>
" Quick fixes
map <Leader>isk :set iskeyword=@,48-57,_,192-255
" Git mappings
map <Leader>c       :call ToggleQuickfixList()<CR>
map <Leader>gl      :Glog<CR>:cw<CR>
map <Leader>Gl      :Glog --<CR>:cw<CR>
map <Leader>gs      :call GitStatus()<CR> 
map <Leader>gd      :call ShowDiff()<CR>
map <Leader>ge      :Gedit<CR>
map <Leader>gpush   :Git push<CR>
map <Leader>gpull   :Git pull<CR>
map <Leader>ggh     :GitGutterLineHighlightsToggle<CR>
map <Leader>ggs     :GitGutterStageHunk<CR>
map <Leader>qg      :!qgit&<CR><CR>
"map <Leader>nu      :windo call ToggleNumbers()<CR>
map <Leader>nu      :call ToggleNumbers()<CR>
map <Leader>nc      :call ToggleLocationList()<CR>
map <Leader>nq      :call ToggleQuickfixList()<CR>
map <Leader>ican    :call Icanhaz()<CR>
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

" UltiSnips + YouCompleteMe
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"""""""""""""""
"  Functions  "
"""""""""""""""

"-----------------------------------------------------------------------------//
fu! ShowDiff()
    Gdiff
    normal zR
    normal gg
endfunction


"-----------------------------------------------------------------------------//
fu! GitStatus()
    tabnew TODO
    Gstatus
endfunction

"-----------------------------------------------------------------------------//
fu! ChangeWrap()
    let l:width=input("Text width: ")
    execute "set textwidth=80".l:width
    echom "Text width changed to ".l:width
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


"----------------------------------------------------------------------------//
fu! SaveView()
    " Only save view if the filename is not empty.
    if strlen(bufname('%'))
        mkview
    endif
endfunction



"----------------------------------------------------------------------------//
" :arg syspaths:    Additional (besides CWD) paths that should be appended to
"                   sys.path
" :arg settings:    Django settings module for the app.
"----------------------------------------------------------------------------//
fu! InitDjangoEnv(...)
py << EOF
import sys
import vim
from os import getcwd, environ
from os.path import join

numargs     = int(vim.eval('a:0'))
syspaths    = []
settings    = 'settings'

if numargs > 0:
    syspaths = vim.eval('a:1')
if numargs > 1:
    settings = vim.eval('a:2')

for path in syspaths:
    if not path.startswith('/'):
        path = join(getcwd(), path)
    if path not in sys.path:
        sys.path.insert(0, path)

sys.path.insert(0, getcwd())

environ['DJANGO_SETTINGS_MODULE'] = settings
EOF
endfunction


"----------------------------------------------------------------------------//
fu! InitGaeEnv(gaepath)
py << EOF
import sys
import vim
from os import getcwd, environ
from os.path import join

gaepath = vim.eval('a:gaepath')

if not gaepath.startswith('/'):
    gaepath = join(getcwd(), gaepath)

paths   = environ['PATH'].split(':')
if gaepath not in paths:
    paths.insert(0, gaepath)

environ['PATH'] = ':'.join(paths)
EOF
endfunction


"----------------------------------------------------------------------------//
fu! RunDoctests()
    let out         = []
    let failed      = 0
    let doctest_cmd = 'python2 -m doctest'

    if exists('g:doctest_cmd')
        let doctest_cmd = g:doctest_cmd
    endif

    echom 'Running doctests..'
    for fpath in g:doctests
        "execute 'silent !./icanhaz doctest '.fpath
        let ret = system(g:doctest_cmd.' '.fpath)
        if v:shell_error == 0
            echom '-- '.fpath.'..ok'
            call add(out, '-- '.fpath.'..ok')
        else
            let failed = 1
            echom '-- '.fpath.'..failed'
            call add(out, '-- '.fpath.'..failed')
            call add(out, ' ')
            for line in split(l:ret, '\n')
                call add(out, ' >   '.line)
            endfor
            call add(out, ' ')
            break
        endif
    endfor

    if failed
        redraw!
        for line in out
            echom line
        endfor
    endif
endfunction


"-----------------------------------------------------------------------------//
fu! ToggleNumbers()
    if getwinvar( winnr(), '&modifiable' )
        if &number == 1
            let &number=0
            let &relativenumber=1
        else
            let &number=1
            let &relativenumber=0
        endif
    endif
endfunction

"----------------------------------------------------------------------------//
fu! SearchProject()
    let pattern=input("Search project (using ack): ")
    redraw!
    echom "Searching for '".l:pattern."'..."
    let args=''
    let ackcmd='ack --column -H --no-heading'

    
    if exists('g:search_ignore_dir')
        let diropt=' --ignore-directory=is:'
        let args=diropt.join(g:search_ignore_dir, diropt)
    endif

    let results = []
    let ack_out = system(ackcmd." '".l:pattern."' ".l:args)
    for line in split(ack_out, '\n')
        let parts = split(line, ':')
        if len(parts) == 4
            call add(results, {
                \'filename':    parts[0],
                \'lnum':        parts[1],
                \'col':         parts[2],
                \'vcol':        1,
                \'text':        parts[3]
            \})
        endif
    endfor
    if len(results) > 0
        call setqflist(results)
        redraw!
        cwindow
    else
        redraw!
        echom "No results found for '".pattern."'"
    endif
endfunction


"----------------------------------------------------------------------------//
func! STL()
  let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
  "let barWidth = &columns - 65 " <-- wild guess

  let takenwidth = len(bufname(winbufnr(winnr()))) + 40
  let cols = &columns / 3
  let barWidth =cols - takenwidth

  let barWidth = barWidth < 3 ? 3 : barWidth

  if line('$') > 1
    let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
  else
    let progress = barWidth/2
  endif

  " line + vcol + %
  let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
  let bar = repeat(' ',pad).' [%1*%'.barWidth.'.'.barWidth.'('
        \.repeat('-',progress )
        \.'%2*0%1*'
        \.repeat('-',barWidth - progress - 1).'%0*%)%<]'

  return stl.bar
endfun


"----------------------------------------------------------------------------//
fu! RemoveTrailingSpaces()
python << EOF
import vim
buf = vim.current.buffer
for i in range(len(buf)):
    buf[i] = buf[i].rstrip()

EOF
endfun


"----------------------------------------------------------------------------//
fu! FormatAssignment() range
python << EOF
import vim
from datetime import datetime as Datetime

buf = vim.current.buffer
beg = int(vim.eval('a:firstline'))
end = int(vim.eval('a:lastline'))

maxwidth = 0
for i in range(beg-1, end):
    line    = buf[i]
    if '=' not in line:
        continue
    name, _ = line.split('=', 1)
    name    = name.rstrip()
    if len(name) > maxwidth:
        maxwidth = len(name)

fmt = '{{name:{}}} = {{value}}'.format(maxwidth)
for i in xrange(beg-1, end):
    line        = buf[i]
    if '=' not in line:
        continue
    name, value = line.split('=', 1)
    buf[i]      = fmt.format(name = name.rstrip(), value = value.lstrip())

EOF
endfunction


"----------------------------------------------------------------------------//
fu! FormatFillWidth() range
python << EOF
import vim
from datetime import datetime as Datetime

buf = vim.current.buffer
beg = int(vim.eval('a:firstline'))
end = int(vim.eval('a:lastline'))

# Find longest line
maxwidth = 0
for i in range(beg-1, end):
    lineLen = len(buf[i])
    if lineLen > maxwidth:
        maxwidth = lineLen

# Append spaces at the end of lines to make them same length as the widest
for i in xrange(beg-1, end):
    lineLen     = len(buf[i])
    if lineLen < maxwidth:
        buf[i] = buf[i] + ' ' * (maxwidth - lineLen)

EOF
endfunction


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
endfunction

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


"----------------------------------------------------------------------------//
" src: http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction


"----------------------------------------------------------------------------//
fu! IcanhazCompletion(ArgLead, CmdLine, CursorPos)
python << EOF
import vim
from subprocess import Popen, PIPE
from os import listdir

def get_cmds():
    return sorted(
        Popen(['icanhaz', '-l'], stdout=PIPE).communicate()[0].split()
    )

cmds    = get_cmds() + os.listdir('./')
cmdLine = vim.eval('a:CmdLine')
curPos  = vim.eval('a:CursorPos')
lead    = vim.eval('a:ArgLead').lower()
if lead:
    lead = lead.split()[-1]

compl = '\n'.join(n for n in cmds if n.lower().startswith(lead))
vim.command('let compl="{}"'.format(compl))
EOF
  return l:compl
endfunction


"----------------------------------------------------------------------------//
fu! Icanhaz()
    let cmd=input("icanhaz ", '', 'custom,IcanhazCompletion')
    "execute "!./icanhaz runtool ".name
    "echom "!icanhaz '".l:cmd."'"
    execute "!icanhaz ".l:cmd
endfunction



""""""""""""""""""
"  Autocommands  "
""""""""""""""""""

" Load local settings
au VimEnter * :call LoadLocal()
au BufWinLeave * call SaveView()
au BufWinEnter *.* silent loadview
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au BufReadPost * :call CustomModeLine("vimex:")
au InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
au InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/

" Change colorcolumn for python files (to conform with pep8)
au FileType python let &colorcolumn="80,81"
au FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
au FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
au FileType * setlocal completeopt-=preview

" Save view for folding


" Highlight extra whitespace at the end of the line
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


" Set statusline with scrollbar
hi def link User1 DiffAdd
hi def link User2 DiffDelete
set stl=%!STL()

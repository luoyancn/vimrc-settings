source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

filetype off
set rtp+=$VIM/bundle/Vundle.vim
call vundle#begin('$VIM/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/buf_it'
Plugin 'mhinz/vim-startify'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'

" Programe language support
"Plugin 'scrooloose/syntastic'
" C and C++
Plugin 'vim-scripts/a.vim'

" Golang
Plugin 'fatih/vim-go'

" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'luoyancn/pyflakes-vim'

" Darcular theme
Plugin 'cohlin/vim-colorschemes'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'morhetz/gruvbox'
Plugin 'chriskempson/vim-tomorrow-theme'

Plugin 'Raimondi/delimitMate'

Plugin 'Yggdroot/indentLine'

Plugin 'iamcco/markdown-preview.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

set termencoding=utf-8
set fileformat=unix
set fileformats=unix
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set langmenu=zh_CN
let $LANG = 'zh_CN.UTF-8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set autoread
set tabstop=4
set softtabstop=4

set noswapfile
set nobackup
set nofoldenable
set cursorline
set autochdir

autocmd FileType python set expandtab
autocmd FileType tex set expandtab
autocmd FileType c set expandtab
autocmd FileType make set noexpandtab
filetype indent off

set noundofile
set completeopt-=preview

let g:indentLine_char='┆'
let g:indentLine_enabled = 1
" Tagbar
let g:tagbar_width=40
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=40
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let g:NERDTreeCopyCmd= 'cp -r '

"startify
let g:startify_files_number = 40

noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" Go tags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_gocode_socket_type = 'tcp'
au FileType go nmap <A-r> :GoDef<cr>

let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = "<C-x><C-o>"
let g:jedi#goto_assignments_command = "<A-g>"
let g:jedi#goto_command = "<A-d>"
let g:jedi#goto_definitions_command = "<A-r>"
let g:jedi#usages_command = "<A-n>"
let g:jedi#documentation_command = "<A-k>"
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "2"
let g:pyflakes_use_quickfix = 0
"let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_check_on_wq = 0

set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1

nnoremap <silent> <F4> :Git branch<CR>
" ############### Gui设置 开始 ##################
if has ("gui_running")
    "新建缓冲区
    nnoremap <silent> <F1> :enew<CR>
    nnoremap <silent> <F2> :bdelete!<CR>
    nnoremap <silent> <F3> :Startify<CR>
    nnoremap <silent> <F9> :NERDTreeToggle<CR>
    nnoremap <silent> <F10> :TagbarToggle<cr>
    nnoremap <silent> <F11> :AV<CR>
    nnoremap <silent> <F12> :A<CR>

    "设置背景颜色"
    " windows下设置字体
    "exec 'set guifont='.iconv('DejaVu_Sans_Mono', &enc, 'utf-8').':h12'
    "i在前面表示使用斜体
    "set gfn=Monaco:h12:cANSI
    "set gfn=Consolas:ih12:cANSI
    "set gfn=Consolas:h12:cANSI
    "set gfn=Consolas:h12:cANSI
    "set gfn=Courier_New:h12:cANSI
    "set gfn=Consolas:h12:cANSI
    "Linux下进行字体的设置
    "set guifont=DejaVu\ Sans\ Mono\ 16
    "set guifont=Consolas\ Blod\ Italic\ 11
    "查看字体信息
    "set guifont?
    "隐藏工具栏
    set guioptions-=T
    " 显示缓冲区列表
    let g:Tb_MoreThanOne = 1
    "始终显示标签页：
    set showtabline=2
    colorscheme py-darcula
    "colorscheme PaperColor
    "colorscheme gruvbox
    "colorscheme Tomorrow-Night-Eighties
    set colorcolumn=80
    highlight ColorColumn guibg=#009ACD
    "打开gui，自动最大化
    au GUIEnter * simalt ~x
    "不进行自动折行
    set nowrap
    " 始终显示状态栏
    set laststatus=2
    " vim-airline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:Powerline_symbols="fancy"

    " 设置powerline使用的字体
    set guifont=Consolas\ for\ Powerline\ FixedD:h16
    let g:airline_right_alt_sep = "\u2b83"
    let g:airline_left_alt_sep = "\u2b81"
    let g:airline_symbols = {}
    let g:airline_left_sep = "\u2b80"
    let g:airline_right_sep = "\u2b82"
    let g:airline_symbols.branch = "\u2b60"
    let g:airline_symbols.readonly = "\u2b64"
    let g:airline_symbols.linenr = "\u2b61"
    let g:airline_symbols.maxlinenr= ""

    "设置顶部tabline栏符号显示"
    let g:airline#extensions#tabline#left_sep = "\u2b80"
    let g:airline#extensions#tabline#left_alt_sep = "\u2b81"
    " 只显示文件名，不显示路径内容
    let g:airline#extensions#tabline#fnamemod = ':p:t'
    let g:airline_theme="dark"
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'

    let g:startify_bookmarks = [
        \ 'F:\个人\新建文本文档.txt',
        \ 'C:\Vim\_vimrc',
        \ 'E:\github.com',
        \ 'E:\workspaces\openstack',
        \ 'E:\workspaces\cprojects\nginx-1.10.2'
    \]
" ############### Gui设置 结束 ##################
else
    "终端的配色设置
    set t_Co=256
endif

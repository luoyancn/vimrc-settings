if has("unix")
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
       set fileencodings=ucs-bom,utf-8,latin1
    endif

    set nocompatible	" Use Vim defaults (much better!)
    set bs=indent,eol,start		" allow backspacing over everything in insert mode
    "set ai			" always set autoindenting on
    "set backup		" keep a backup file
    set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                            " than 50 lines of registers
    set history=50		" keep 50 lines of command line history
    set ruler		" show the cursor position all the time

    " Only do this part when compiled with support for autocommands
    if has("autocmd")
      augroup fedora
      autocmd!
      " In text files, always limit the width of text to 78 characters
      " autocmd BufRead *.txt set tw=78
      " When editing a file, always jump to the last cursor position
      autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
      " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
      autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
      " start with spec file template
      autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
      augroup END
    endif

    if has("cscope") && filereadable("/usr/bin/cscope")
       set csprg=/usr/bin/cscope
       set csto=0
       set cst
       set nocsverb
       " add any database in current directory
       if filereadable("cscope.out")
          cs add $PWD/cscope.out
       " else add database pointed to by environment
       elseif $CSCOPE_DB != ""
          cs add $CSCOPE_DB
       endif
       set csverb
    endif

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if &t_Co > 2 || has("gui_running")
      syntax on
      set hlsearch
    endif

    filetype plugin on

    if &term=="xterm"
         set t_Co=8
         set t_Sb=[4%dm
         set t_Sf=[3%dm
    endif

    " Don't wake up system with blinking cursor:
    " http://www.linuxpowertop.org/known.php
    let &guicursor = &guicursor . ",a:blinkon0"

elseif has("win32")
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
    "BUG info: https://github.com/davidhalter/jedi-vim/issues/870
    "py import os; sys.executable=os.path.join(sys.prefix, 'python.exe')
endif

filetype off
set rtp+=$VIM/bundle/Vundle.vim
call vundle#begin('$VIM/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vim theme
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'kadekillary/subtle_solo'
Plugin 'morhetz/gruvbox'
Plugin 'roosta/vim-srcery'
Plugin 'srcery-colors/srcery-vim'

Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/buf_it'
Plugin 'mhinz/vim-startify'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'Yggdroot/indentLine'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'
" Keyboard sound
Plugin 'skywind3000/vim-keysound'

if !has("win32")
    Plugin 'mileszs/ack.vim'
endif

" Programe language support
"Plugin 'scrooloose/syntastic'
" C and C++
Plugin 'vim-scripts/a.vim'

" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'luoyancn/pyflakes-vim'

" Golang
Plugin 'fatih/vim-go'
Plugin 'visualfc/gocode', {'rtp': 'vim/'}

if !has("gui_running")
    Plugin 'ap/vim-buftabline'
endif

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

set cursorline autochdir autoread
set noswapfile nobackup nofoldenable noundofile noautoindent nocindent nosmartindent nowrap
set colorcolumn=80 laststatus=2
highlight ColorColumn guibg=#009ACD

set tabstop=4 softtabstop=4 expandtab
autocmd FileType html,javascript set tabstop=2 softtabstop=2 expandtab
autocmd FileType python,tex,vim set tabstop=4 softtabstop=4 expandtab
autocmd FileType c,h,go,cpp,make set tabstop=8 softtabstop=8 noexpandtab
filetype indent off
set noshowmode

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
let NERDTreeShowHidden=1
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
let g:go_autodetect_gopath = 1
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
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'gocode']
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'gocode']

if has("win32")
    let g:go_gocode_socket_type = 'tcp'
endif
let g:go_gocode_autobuild = 1
let g:go_gocode_propose_builtins = 1
let g:go_gocode_unimported_packages = 1

let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter', 'gocode']
au FileType go nmap <A-r> :GoDef<cr>
au FileType go nmap <A-n> :GoReferrers<cr>

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

let g:webdevicons_enable = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitreview'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitconfig'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.git'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['conf'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cfg'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['xml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['go'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rst'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['crt'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['key'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['dockerfile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['proto'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['toml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pem'] = ''

let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
"let s:darkBlue = "009ACD"
let s:darkBlue = "00B2EE"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['py'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['c'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['json'] = s:lightGreen
let g:NERDTreeExtensionHighlightColor['ini'] = s:yellow
let g:NERDTreeExtensionHighlightColor['go'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['yaml'] = s:darkOrange
let g:NERDTreeExtensionHighlightColor['yml'] = s:darkOrange
let g:NERDTreeExtensionHighlightColor['conf'] = s:orange
let g:NERDTreeExtensionHighlightColor['cfg'] = s:orange
let g:NERDTreeExtensionHighlightColor['xml'] = s:lightGreen
let g:NERDTreeExtensionHighlightColor['java'] = s:red
let g:NERDTreeExtensionHighlightColor['tex'] = s:lightGreen
let g:NERDTreeExtensionHighlightColor['pdf'] = s:red
let g:NERDTreeExtensionHighlightColor['rst'] = s:lightGreen
let g:NERDTreeExtensionHighlightColor['key'] = s:red
let g:NERDTreeExtensionHighlightColor['crt'] = s:red
let g:NERDTreeExtensionHighlightColor['dockerfile'] = s:darkBlue

let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" 只显示文件名，不显示路径内容
let g:airline_section_c = '%t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols="fancy"
let g:airline_symbols = {}
let g:airline_symbols.branch = ""
let g:airline_symbols.readonly = ""
let g:airline_symbols.linenr = ""
let g:airline_symbols.maxlinenr= ""
let g:airline_left_alt_sep = ""
let g:airline_left_sep = ""
let g:airline_right_alt_sep = ""
let g:airline_right_sep = ""

if has("win32")
    let g:keysound_enable = 1
    let g:keysound_theme = 'typewriter'
    let g:keysound_volume = 1000
elseif has("unix")
    map <A-s> :Ack!<Space>
endif

if has("gui_running")
    set guioptions-=T
    let g:Tb_MoreThanOne = 1
    "set guioptions-=m
    set background=dark
    colorscheme srcery
    "let g:airline_theme="papercolor"
    "let g:airline_theme = "srcery"
    let g:airline_theme = "powerlineish"
    nnoremap <silent> <F1> :enew<CR>
    nnoremap <silent> <F2> :bdelete!<CR>
    nnoremap <silent> <F3> :Startify<CR>
    nnoremap <silent> <F7> :NERDTreeToggle<CR>
    nnoremap <silent> <F9> :NERDTreeFind<CR>
    nnoremap <silent> <F10> :TagbarToggle<cr>
    nnoremap <silent> <F11> :AV<CR>
    nnoremap <silent> <F12> :A<CR>
    au FileType go nnoremap <silent> <F5> :GoInstall<CR>
    "set showtabline=2
    map  <silent> <S-Insert>  "+p
    imap <silent> <S-Insert>  <Esc>"+pa

    if has("unix")
        set guifont=CodeNewRoman\ NF\ 16
    elseif has("win32")
        "打开gui，自动最大化
        au GUIEnter * simalt ~x
        set guifont=CodeNewRoman\ Nerd\ Font\ Mono:h16
        let g:startify_bookmarks = [
            \ 'F:\个人\新建文本文档.txt',
            \ 'C:\Vim\_vimrc',
            \ 'E:\github.com',
            \ 'E:\workspaces\openstack',
            \ 'E:\workspaces\cprojects\nginx-1.10.2'
        \]
    endif
else
    set t_Co=256
    set background=dark
    let g:ctrlp_types = ['buf', 'fil', 'mru']
    let g:buftabline_show = 2
    let g:buftabline_numbers = 2
endif

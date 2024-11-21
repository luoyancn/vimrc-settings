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

" if using neovim, the init.vim should be placed under follows:
" /usr/share/nvim/sysinit.vim
" /etc/xdg/nvim/init.vim
" ~/.config/nvim/init.vim

filetype off
if has('nvim')
  if has("win32")
    set rtp+=C:\Vim\bundle\Vundle.vim
    call vundle#begin('C:\Vim\bundle')
  else
    set rtp+=/usr/share/vim/bundle/Vundle.vim
    call vundle#begin('/usr/share/vim/bundle')
  endif
else
  set rtp+=$VIM/bundle/Vundle.vim
  call vundle#begin('$VIM/bundle')
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vim theme
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'kadekillary/subtle_solo'
Plugin 'morhetz/gruvbox'
Plugin 'srcery-colors/srcery-vim'
Plugin 'frazrepo/vim-rainbow'
Plugin 'vim-scripts/LargeFile'

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
" Plugin 'skywind3000/vim-keysound'
Plugin 'liuchengxu/vim-clap'
" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'luoyancn/pyflakes-vim'

" Rust
"Plugin 'racer-rust/vim-racer'
"Plugin 'maralla/completor.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'dense-analysis/ale'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'mattn/vim-lsp-settings'
"Plugin 'keremc/asyncomplete-racer.vim'

if has('python3')
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    Plugin 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

if !has("win32")
    Plugin 'mileszs/ack.vim'
    "Plugin 'xavierd/clang_complete'
    Plugin 'keremc/asyncomplete-clang.vim'
    " For C/C++, clangd must be installed
    " On Fedora
    " dnf/yum install clang-tools-extra -y
    " On CentOS/Redhat
    " yum install clang -y
    " On Manjaro
    " pacman -Syu clang
endif

" Programe language support
"Plugin 'scrooloose/syntastic'
" C and C++
Plugin 'vim-scripts/a.vim'

" Golang
"Plugin 'fatih/vim-go'
"Plugin 'visualfc/gocode', {'rtp': 'vim/'}

if !has("gui_running")
    "Plugin 'ap/vim-buftabline'
endif

call vundle#end()            " required
filetype plugin indent on

set mouse=""
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
au FocusGained,BufEnter * :checktime
au CursorHold,CursorHoldI * checktime
augroup cursorline
  au!
  au ColorScheme * hi clear CursorLine
               \ | hi CursorLine gui=underline cterm=underline
augroup END

set noswapfile nobackup nofoldenable noundofile noautoindent nocindent nosmartindent nowrap
set colorcolumn=80,80 laststatus=2
highlight ColorColumn guibg=#009ACD ctermbg=None
set noshowmode
set foldmethod=indent
set foldlevelstart=99
set fillchars=eob:\ ,vert:\│
autocmd ColorScheme * highlight VertSplit cterm=bold ctermfg=232 ctermbg=None
autocmd ColorScheme * highlight VertSplit guifg=#121212

set tabstop=4 softtabstop=4 expandtab
autocmd FileType html,javascript set tabstop=2 softtabstop=2 expandtab
autocmd FileType python,tex,vim set tabstop=4 softtabstop=4 expandtab
autocmd FileType c,h,go,cpp,make set tabstop=8 softtabstop=8 noexpandtab
autocmd FileType lua set tabstop=8 softtabstop=8 expandtab
filetype indent off

set completeopt-=preview

"let g:indentLine_char='┆'
let g:indentLine_char='│'
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
let g:NERDTreeStatusline = 'Nerdtree'

"startify
let g:startify_files_number = 10

noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w
" Open the terminal in VIM at the bottom, Only for VIM >= 8.1
nmap <C-\> :bot :ter ++rows=12<cr>
nmap <C-s> :FixWhitespace<cr>

" Go tags
"let g:go_autodetect_gopath = 1
"let g:tagbar_type_go = {
"    \ 'ctagstype' : 'go',
"    \ 'kinds'     : [
"        \ 'p:package',
"        \ 'i:imports:1',
"        \ 'c:constants',
"        \ 'v:variables',
"        \ 't:types',
"        \ 'n:interfaces',
"        \ 'w:fields',
"        \ 'e:embedded',
"        \ 'm:methods',
"        \ 'r:constructor',
"        \ 'f:functions'
"    \ ],
"    \ 'sro' : '.',
"    \ 'kind2scope' : {
"        \ 't' : 'ctype',
"        \ 'n' : 'ntype'
"    \ },
"    \ 'scope2kind' : {
"        \ 'ctype' : 't',
"        \ 'ntype' : 'n'
"    \ },
"    \ 'ctagsbin'  : 'gotags',
"    \ 'ctagsargs' : '-sort -silent'
"\ }
"
"let g:go_fmt_command = "goimports"
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_interfaces = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_types = 1
"let g:go_highlight_extra_types = 1
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'gocode']
"let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'gocode']
"" Must be go >= 1.12
"let g:go_auto_type_info = 1
"let g:go_info_mode = 'gopls'
"
"if has("win32")
"    let g:go_gocode_socket_type = 'tcp'
"endif
"let g:go_gocode_autobuild = 1
"let g:go_gocode_propose_builtins = 1
"let g:go_gocode_unimported_packages = 1
"
"let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter', 'gocode']
"au FileType go nmap <A-r> :GoDef<cr>
"au FileType go nmap <A-n> :GoReferrers<cr>
"
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = "<C-x><C-o>"
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 1
let g:jedi#smart_auto_mappings = 1
let g:pyflakes_use_quickfix = 0
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_check_on_wq = 0

if !has('nvim')
  set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
endif

let g:webdevicons_enable = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_startify = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitreview'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitconfig'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.git'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.lock'] = ''

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
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rs'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['lock'] = ''

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
"let g:airline_experimental = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_spell=1
let g:airline_section_c = '%t'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols="fancy"
let g:airline_symbols = {}
let g:airline_symbols.branch = ""
let g:airline_symbols.readonly = ""
let g:airline_symbols.linenr = ""
let g:airline_symbols.colnr = ""
let g:airline_symbols.maxlinenr= ""
let g:airline_left_sep = ""
"let g:airline_left_alt_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_sep = ""
"let g:airline_right_alt_sep = ""
let g:airline_right_alt_sep = ""
let g:airline#extensions#lsp#enabled = 1

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'Buffers'
let g:airline#extensions#tabline#tabs_label = 'TABS'

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = ""
let g:airline#extensions#ale#warning_symbol = ""

if has("win32")
    "let g:keysound_enable = 1
    "let g:keysound_theme = 'typewriter'
    "let g:keysound_volume = 1000
else
    map <A-s> :Ack!<Space>
    "let g:clang_library_path='/usr/lib64/libclang.so.13'
endif

let g:lsp_settings = {
\  'rust-analyzer': {
\   'initialization_options': {
\     'cargo': {
\       'loadOutDirsFromCheck': v:true,
\       'autoreload': v:true,
\     },
\     'procMacro': {
\       'enable': v:true,
\     },
\   },
\  },
\}

let g:rustfmt_autosave = 1
let g:rustfmt_options = '--config max_width=80'
let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_document_highlight_enabled = 1
let g:lsp_document_code_action_signs_enabled = 0
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = '/var/log/vim-lsp.log'

if has('nvim')
  let g:ale_use_neovim_diagnostics_api = 0
endif

let g:ale_virtualtext_cursor = '0'
let g:ale_virtualtext_prefix = ' '
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_sign_style_error = ""
let g:ale_sign_style_warning = ""
let g:ale_echo_msg_format = '%severity% - %s'
let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_cursor = 0
let g:ale_detail_to_floating_preview = 1
let g:ale_cursor_detail = 1
let g:ale_close_preview_on_insert = 1
"let g:ale_echo_msg_format = '[%severity%] - %s'
" let g:ale_lsp_suggestions = 1

let g:ale_linters = {'rust': ['cargo']}

" For C/C++ projects, ALE cannot determine the self-defined header files.
" To resolv this problem, a file named compile_commands.json is need.
" And the compile_commands.json can be generated by cmake. The follow
" is an example of how to generate a compile_commands.json file:
"
" cd projects
" mkdir build
" cd build
" cmake ../ -DCMAKE_EXPORT_COMPILE_COMMANDS=1
"
" After the operations like above, just copy or move the file named
" compile_commands.json from build to the parent director, and open
" the vim again, ALE can recognize all file need

let g:ale_rust_cargo_use_check=0
let g:ale_rust_cargo_check_tests=1
let g:ale_rust_cargo_check_examples=1
let g:ale_rust_cargo_default_feature_behavior=('all')
let g:ale_rust_cargo_use_clippy=1
let g:ale_rust_cargo_clippy_options = '--allow clippy::too_many_arguments --allow clippy::single_component_path_imports --allow clippy::redundant_field_names --allow clippy::enum_variant_names --allow clippy::upper_case_acronyms'

let g:ale_python_flake8_options = '--ignore=I201,D103,D104,D100,D103,D105,D101,D102,D107 --import-order-style edited'
let g:ale_python_pylint_options = '--disable=C0103,C0114,C0115,C0116,C0123,C0302,D101,D102,D103,D104,D107,R0201,R0902,R0904,R0911,R0912,R0913,R0914,R0915,R1702,R1710,W0212,W0511,W0603,W0621,W0703,W0706'
let g:ale_python_auto_pipenv = 1
let g:ale_python_bandit_auto_pipenv = 1
let g:ale_python_black_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_python_flakehell_auto_pipenv = 1
let g:ale_python_isort_auto_pipenv = 1
let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_prospector_auto_pipenv = 1
let g:ale_python_pycodestyle_auto_pipenv = 1
let g:ale_python_pydocstyle_auto_pipenv = 1
let g:ale_python_pyflakes_auto_pipenv = 1
let g:ale_python_pylama_auto_pipenv = 1
let g:ale_python_pylsp_auto_pipenv = 1
let g:ale_python_pyre_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_python_pylint_change_directory = 1
let g:ale_python_pylint_auto_poetry = 1

"if executable('rust-analyzer')
"  au User lsp_setup call lsp#register_server({
"        \   'name': 'Rust Language Server',
"        \   'cmd': {server_info->['rust-analyzer']},
"        \   'whitelist': ['rust'],
"        \   'initialization_options': {
"        \     'cargo': {
"        \       'loadOutDirsFromCheck': v:true,
"        \     },
"        \     'procMacro': {
"        \       'enable': v:true,
"        \     },
"        \   },
"        \ })
"endif
"autocmd User asyncomplete_setup call asyncomplete#register_source(
"    \ asyncomplete#sources#clang#get_source_options())

" For Python, Must execute the commands like follows:
" dnf install python3-language-server python3-autopep8 python3-mccabe \
" python3-flake8 python3-flake8-import-order python3-flake8-polyfill \
" python3-pyflakes python3-pylint python3-pydocstyle python3-rope python3-yapf -y
" or pip install autopep8 mccabe pyflakes pylint pydocstyle rope yapf \
" flake8 flake8-import-order flake8-polyfill
" For Debian
" apt install python3-pyls python3-autopep8 python3-mccabe \
" python3-flake8 python3-rope python3-yapf python3-flake8-polyfill python3-pyflakes -y
"if executable('pyls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'allowlist': ['python'],
"        \ })
"endif
"

set omnifunc=lsp#complete

if has('python3')
    let g:UltiSnipsExpandTrigger="<tab>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

" let g:WebDevIconsOS='Darwin'
let g:tagbar_show_tag_linenumbers = 1
let g:tagbar_show_data_type = 1

let g:rainbow_active = 1
let NERDTreeWinSize = 25
let g:tagbar_width = 25

if has('nvim')
  colorscheme PaperColor
  let g:airline_theme="papercolor"
  set wildoptions=fuzzy
else
  colorscheme srcery
  "let g:airline_theme = "srcery"
  let g:airline_theme = "powerlineish"
endif

if has("gui_running")
    set guioptions-=T
    let g:Tb_MoreThanOne = 1
    "set guioptions-=m
    set background=dark
    nnoremap <silent> <F1> :enew<CR>
    nnoremap <silent> <F2> :bdelete!<CR>
    nnoremap <silent> <F3> :Startify<CR>
    nnoremap <silent> <F7> :NERDTreeToggle<CR>
    nnoremap <silent> <F9> :NERDTreeFind<CR>
    nnoremap <silent> <F10> :TagbarToggle<cr>
    nnoremap <silent> <F11> :AV<CR>
    nnoremap <silent> <F12> :A<CR>
    "au FileType go nnoremap <silent> <F5> :GoInstall<CR>
    let g:jedi#goto_assignments_command = "<A-g>"
    let g:jedi#goto_command = "<A-d>"
    let g:jedi#goto_definitions_command = "<A-m>"
    let g:jedi#usages_command = "<A-r>"
    nmap <A-r> :LspReferences<cr>
    nmap <A-d> :LspDefinition<cr>
    nmap <S-F1> :LspCargoReload<cr>
    "set showtabline=2
    map  <silent> <S-Insert>  "+p
    imap <silent> <S-Insert>  <Esc>"+pa
    if has("unix")
        if has('nvim')
          set guifont=CodeNewRoman\ Nerd\ Font\ Mono:h16
        else
          set guifont=CodeNewRoman\ Nerd\ Font\ Mono\ 16
        endif
    elseif has("win32")
        "打开gui，自动最大化
        au GUIEnter * simalt ~x
        set guifont=CodeNewRoman\ Nerd\ Font\ Mono:h16
        if exists('g:neovide')
          set linespace=6
          let g:neovide_scale_factor = 1.0
        endif
    endif
else
    set t_Co=256
    set background=dark
    let g:srcery_bg_passthrough=1
    let g:srcery_hard_black_terminal_bg=1
    let g:srcery_bold = 1
    let g:srcery_italic = 1
    let g:srcery_inverse_matches = 1
    let g:srcery_inverse_match_paren = 1
    let g:srcery_italic_types = 1
    autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg
    let g:jedi#goto_assignments_command = "<C-g>"
    let g:jedi#goto_command = "<C-d>"
    let g:jedi#goto_definitions_command = "<C-m>"
    let g:jedi#usages_command = "<S-f>"
    nmap <S-f> :LspReferences<cr>
    nmap <C-d> :LspDefinition<cr>
    nmap <S-F1> :LspCargoReload<cr>
    let g:ctrlp_types = ['buf', 'fil', 'mru']
    let g:buftabline_show = 2
    let g:buftabline_numbers = 2
    let g:tagbar_left = 1
    "let g:tagbar_width = 30
    let NERDTreeWinPos = "right"
endif
let g:clap_plugin_experimental = v:true
let g:clap_start_server_on_startup=0
let g:clap_provider_alias = {}
nmap <C-k> :Clap<cr>

" 增加ale的警告与错误提示颜色
autocmd VimEnter *
\ if g:colors_name == 'srcery' && exists('g:ale_enabled') |
\   hi ALEWarning ctermfg=252 ctermbg=53 guifg=#eeeeee guibg=#8700af |
\   hi ALEError ctermfg=15 ctermbg=1 guifg=White guibg=Red |
\ endif

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
autocmd FileType python,tex,vim,rust set tabstop=4 softtabstop=4 expandtab
autocmd FileType c,h,go,cpp,make set tabstop=8 softtabstop=8 noexpandtab
autocmd FileType lua set tabstop=8 softtabstop=8 expandtab
filetype indent off
set completeopt-=preview

noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w
" Open the terminal in VIM at the bottom, Only for VIM >= 8.1
nmap <C-\> :bot :ter ++rows=12<cr>
nmap <C-s> :FixWhitespace<cr>
if !has('nvim')
  set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
endif

let g:brown = "905532"
let g:aqua =  "3AFFDB"
let g:blue = "689FB6"
"let s:darkBlue = "009ACD"
let g:darkBlue = "00B2EE"
let g:purple = "834F79"
let g:lightPurple = "834F79"
let g:red = "AE403F"
let g:beige = "F5C06F"
let g:yellow = "F09F17"
let g:orange = "D4843E"
let g:darkOrange = "F16529"
let g:pink = "CB6F6F"
let g:salmon = "EE6E73"
let g:green = "8FAA54"
let g:lightGreen = "31B53E"
let g:white = "FFFFFF"
let g:rspec_red = 'FE405F'
let g:git_orange = 'F54D27'

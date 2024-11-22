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

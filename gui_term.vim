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
    nmap <A-d> :LspDeclaration<cr>
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

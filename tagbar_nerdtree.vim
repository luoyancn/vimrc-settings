"let g:indentLine_char='┆'
let g:indentLine_char='│'
let g:indentLine_enabled = 1

" Tagbar
let g:tagbar_width=40
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_map_showproto = ''
let g:tagbar_show_tag_linenumbers = 1
let g:tagbar_show_data_type = 1
let g:tagbar_width = 25

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize = 25
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let g:NERDTreeCopyCmd= 'cp -r '
let g:NERDTreeStatusline = 'Nerdtree'
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['py'] = g:darkBlue
let g:NERDTreeExtensionHighlightColor['c'] = g:darkBlue
let g:NERDTreeExtensionHighlightColor['json'] = g:lightGreen
let g:NERDTreeExtensionHighlightColor['ini'] = g:yellow
let g:NERDTreeExtensionHighlightColor['go'] = g:darkBlue
let g:NERDTreeExtensionHighlightColor['yaml'] = g:darkOrange
let g:NERDTreeExtensionHighlightColor['yml'] = g:darkOrange
let g:NERDTreeExtensionHighlightColor['conf'] = g:orange
let g:NERDTreeExtensionHighlightColor['cfg'] = g:orange
let g:NERDTreeExtensionHighlightColor['xml'] = g:lightGreen
let g:NERDTreeExtensionHighlightColor['java'] = g:red
let g:NERDTreeExtensionHighlightColor['tex'] = g:lightGreen
let g:NERDTreeExtensionHighlightColor['pdf'] = g:red
let g:NERDTreeExtensionHighlightColor['rst'] = g:lightGreen
let g:NERDTreeExtensionHighlightColor['key'] = g:red
let g:NERDTreeExtensionHighlightColor['crt'] = g:red
let g:NERDTreeExtensionHighlightColor['dockerfile'] = g:darkBlue

"startify
let g:startify_files_number = 40
if has("win32")
    "let g:keysound_enable = 1
    "let g:keysound_theme = 'typewriter'
    "let g:keysound_volume = 1000
else
    map <A-s> :Ack!<Space>
    "let g:clang_library_path='/usr/lib64/libclang.so.13'
endif

let g:rainbow_active = 1
let g:clap_plugin_experimental = v:true
let g:clap_start_server_on_startup=0
let g:clap_provider_alias = {}
nmap <C-k> :Clap<cr>

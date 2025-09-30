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

" 指定rust-analyzer路径，新版本的存在bug，不能在vim当中自动补齐
" BUG: https://github.com/rust-lang/rust-analyzer/issues/19401
if has("win32") ==1 || has("win64") == 1
    let g:rust_analyzer_path = expand('d:/github.com/binary/rust-analyzer.exe')
    let g:lua_path = expand('d:/github.com/binary/lua-language-server-3.15.0/bin/lua-language-server.exe')
    let g:lua_main_path = expand('d:/github.com/binary/lua-language-server-3.15.0/main.lua')
else
    let g:rust_analyzer_path = '/mnt/d/github.com/binary/rust-analyzer'
    let g:lua_path = '/mnt/d/github.com/binary/lua-language-server-3.15.0/bin/lua-language-server'
    let g:lua_main_path = '/mnt/d/github.com/binary/lua-language-server-3.15.0/main.lua'
endif
let g:lsp_settings = {
\  'rust-analyzer': {
\   'cmd': [g:rust_analyzer_path],
\   'initialization_options': {
\     'cargo': {
\       'loadOutDirsFromCheck': v:true,
\       'allFeatures': v:true,
\       'autoreload': v:true,
\       'buildScripts': {
\         'enable': v:true,
\       },
\     },
\     'completion': {
\       'autoimport': {'enable': v:true},
\       'postfix': {'enable': v:true},
\     },
\     'procMacro': {
\       'enable': v:true,
\     },
\   },
\  },
\  'sumneko-lua-language-server': {
\    'cmd': [g:lua_path, '-E', '-e', 'LANG=en', g:lua_main_path, '$*']
\  }
\}
function! s:RustCapabilities(server_info) abort
  let caps = lsp#default_get_supported_capabilities(a:server_info)
  if get(a:server_info, 'name', '') ==# 'rust-analyzer'
    let caps.textDocument.completion.completionItem.resolveSupport = {
          \ 'properties': ['additionalTextEdits', 'tags', 'labelDetails',
          \                'detail', 'documentation', 'filterText',
          \                'textEdit', 'command']
          \ }
  endif
  return caps
endfunction
let g:lsp_get_supported_capabilities = [function('s:RustCapabilities')]

let g:rustfmt_autosave = 1
let g:rustfmt_options = '--config max_width=80,use_small_heuristics="Max",where_single_line=true'
let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_document_highlight_enabled = 1
let g:lsp_document_code_action_signs_enabled = 0
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = 'vim-lsp.log'

if has('nvim')
  let g:ale_use_neovim_diagnostics_api = 0
  let g:python3_host_prog = '/usr/bin/python3.6'
endif

let g:ale_virtualtext_cursor = '0'
let g:ale_virtualtext_prefix = ' '
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_sign_style_error = ""
let g:ale_sign_style_warning = ""
let g:ale_echo_msg_format = '%severity% - %s'
let g:ale_echo_msg_error_str = ''
"let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_cursor = 0
let g:ale_detail_to_floating_preview = 1
let g:ale_cursor_detail = 1
let g:ale_close_preview_on_insert = 1
"let g:ale_echo_msg_format = '[%severity%] - %s'
" let g:ale_lsp_suggestions = 1

let g:ale_linters = {'rust': ['cargo']}
let g:ale_lua_language_server_executable = g:lua_path

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
" 增加ale的警告与错误提示颜色
autocmd VimEnter *
\ if g:colors_name == 'srcery' && exists('g:ale_enabled') |
\   hi ALEWarning ctermfg=252 ctermbg=53 guifg=#eeeeee guibg=#8700af |
\   hi ALEError ctermfg=15 ctermbg=1 guifg=White guibg=Red |
\ endif

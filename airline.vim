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
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline#extensions#tabline#buffer_nr_show = 0
"let g:airline#extensions#tabline#buffer_nr_format= '%s '

"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#tab_nr_type= 2
"let g:airline#extensions#tabline#show_tab_type = 1

let g:airline#extensions#tabline#buffers_label = 'Buffers'
let g:airline#extensions#tabline#tabs_label = 'TABS'

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = ""
let g:airline#extensions#ale#warning_symbol = ""

if has('nvim')
  colorscheme PaperColor
  let g:airline_theme="papercolor"
else
  colorscheme srcery
  "let g:airline_theme = "srcery"
  let g:airline_theme = "powerlineish"
endif

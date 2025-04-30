let g:webdevicons_enable = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_startify = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
if $TERM_PROGRAM == "WezTerm"
    let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {
      \'.gitignore': "",
      \'.gitreview': "",
      \'.gitconfig': "",
      \'.git': "",
      \'.github': "",
      \'.config': "",
      \ }
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
      \'conf': "",
      \'cfg': "",
      \'yml': "",
      \'xml': "",
      \'go': "",
      \'txt': "",
      \'pdf': "",
      \'crt': "",
      \'key': "",
      \'dockerfile': "",
      \'proto': "",
      \'toml': "ﭨ",
      \'pem': "",
      \'svg': "ﰟ",
      \'mp4': "ﴼ",
      \'properties': "",
      \'lock': ""
      \ }
else
    let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {
      \'.gitignore': "",
      \'.gitreview': "",
      \'.gitconfig': "",
      \'.git': "",
      \'.github': "",
      \'.config': "",
      \ }
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
      \'conf': "",
      \'cfg': "",
      \'yml': "",
      \'xml': "",
      \'go': "",
      \'tex': "",
      \'txt': "󱄽",
      \'pdf': "",
      \'crt': "",
      \'key': "",
      \'dockerfile': "",
      \'proto': "",
      \'toml': "",
      \'pem': "",
      \'svg': "󰜡",
      \'mp4': "󰠾",
      \'properties': "",
      \'lock': "󰞚"
      \ }
endif

local lazypath = vim.env.VIM .. '/lazy.nvim'
local plug_root_path = vim.env.VIM .. '/bundle'
local rust_analyzer_path
-- 目前neovim对文件夹的快捷方式支持可能不是很好，
-- 最好使用全路径
-- 但vim可以支持快捷方式
if vim.fn.has('win32') ==1 or vim.fn.has('win64') == 1 then
        lazypath = 'D:\\github.com\\bundle\\lazy.nvim'
        plug_root_path = 'D:\\github.com\\bundle'
        rust_analyzer_path = 'C:\\Vim\\rust-analyzer.exe'
else
        rust_analyzer_path = '/usr/local/bin/rust-analyzer'
end
vim.opt.rtp:prepend(lazypath)
if vim.fn.has('gui_running') == 0 then
        vim.g.tagbar_left = 1
end

-- 获取当前neovim的版本
-- 是否是0.11以后的版本
local nvim_version = vim.version()
local is_nvim_011_or_newer = (nvim_version.major > 0)
    or (nvim_version.major == 0 and nvim_version.minor >= 11)

local function lsp_config()
        if is_nvim_011_or_newer then
                -- 这里是 rust-analyzer 示例，其他语言按需加
                vim.lsp.set_log_level("OFF")
                --vim.lsp.enable({'rust_analyzer', 'pylsp', 'taplo', 'clangd', 'lua_ls'})
                vim.lsp.enable({'rust_analyzer', 'pylsp', 'taplo', 'lua_ls'})
                vim.lsp.config('rust_analyzer',
                        {
                                cmd = {rust_analyzer_path},
                                settings = {
                                        ['rust-analyzer'] = {
                                                cargo = {
                                                        loadOutDirsFromCheck = true,
                                                        autoreload = true,
                                                        buildScripts = {
                                                                enable = true,
                                                        },
                                                },
                                                diagnostics = {
                                                        enable = false,
                                                },
                                                procMacro = {
                                                        enable = true,
                                                },
                                        },
                                },
                                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        }
                )
                vim.lsp.config('lua_ls',
                        {
                                settings = {
                                        Lua = {
                                                diagnostics = { enable = false },
                                        },
                                },
                                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        }
                )
                vim.diagnostic.config({
                        virtual_text = false,
                        signs = false,
                        underline = false,
                        update_in_insert = false,
                })
        else
                local lspconfig = require('lspconfig')
                lspconfig.rust_analyzer.setup({
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        settings = {
                                ['rust-analyzer'] = {
                                        cargo = {
                                                loadOutDirsFromCheck = true,
                                                autoreload = true,
                                                buildScripts = { enable = true },
                                        },
                                        diagnostics = { enable = false },
                                        procMacro = { enable = true },
                                },
                        },
                })
                lspconfig.pylsp.setup({
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                })
                lspconfig.lua_ls.setup({
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        settings = {
                                Lua = {
                                        diagnostics = { enable = false },
                                },
                        },
                })
                lspconfig.taplo.setup({
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                })
        end
end

local function airline_config()
        vim.g.airline_powerline_fonts = true
        vim.g.airline_theme = 'powerlineish'
        -- airline 基础检测设置
        vim.g.airline_detect_modified = 1
        vim.g.airline_detect_paste = 1
        vim.g.airline_detect_crypt = 1
        vim.g.airline_detect_spell = 1

        -- 中间 section 显示当前文件名
        vim.g.airline_section_c = '%t'

        vim.g.airline_symbols = {
          branch = ' ',
          readonly = '',
          linenr = '',
          colnr = '',
          maxlinenr = '',
          modified = '+',
          whitespace = '☲ ',
          ellipsis = '...',
          paste = 'PASTE',
          spell = 'SPELL',
          space = ' ',
          dirty = '',
          keymap= 'Keymap:',
          crypt = '🔒',
          notexists = 'Ɇ'
        }

        -- 分隔符
        vim.g.airline_left_sep = ''
        vim.g.airline_left_alt_sep = ''
        vim.g.airline_right_sep = ''
        vim.g.airline_right_alt_sep = ''
        vim.g['airline#extensions#lsp#enabled'] = true
        vim.g['airline#extensions#tagbar#enabled'] = true
        vim.g['airline#extensions#tabline#enabled'] = true
        vim.g['airline#extensions#tabline#fnamemod'] = ':t'
        vim.g['airline#extensions#tabline#fnamecollapse'] = 1
        vim.g['airline#extensions#tabline#fnametruncate'] = 0
        vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
        vim.g['airline#extensions#tabline#buffer_nr_show'] = 0
        vim.g['airline#extensions#tabline#buffers_label'] = 'Buffers'
        vim.g['airline#extensions#tabline#tabs_label'] = 'TABS'
        vim.g['airline#extensions#whitespace#enabled'] = true
        vim.g['airline#extensions#whitespace#symbol'] = '!'
        vim.g['airline#extensions#ale#enabled'] = true
        vim.g['airline#extensions#ale#error_symbol'] = ''
        vim.g['airline#extensions#ale#warning_symbol'] = ''
        vim.g['airline#extensions#tabline#buffer_idx_format'] = {
                ['0'] = '󰎡 ',
                ['1'] = '󰎤 ',
                ['2'] = '󰎧 ',
                ['3'] = '󰎪 ',
                ['4'] = '󰎭 ',
                ['5'] = '󰎱 ',
                ['6'] = '󰎳 ',
                ['7'] = '󰎶 ',
                ['8'] = '󰎹 ',
                ['9'] = '󰎼 ',
                ['10'] = '󰽽 ',
        }
end

local function gruvbox_init()
        vim.g.gruvbox_material_background = 'medium'
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_disable_italic_comment = 1
end

local function webdevicon_init()
        vim.g.webdevicons_enable = true
        vim.g.webdevicons_enable_ctrlp = true
        vim.g.webdevicons_enable_nerdtree = true
        vim.g.webdevicons_enable_airline_tabline = true
        vim.g.webdevicons_enable_airline_statusline = true
        vim.g.webdevicons_enable_startify = true
        vim.g.webdevicons_conceal_nerdtree_brackets = true
        vim.g.WebDevIconsUnicodeDecorateFileNodes = true
        vim.g.DevIconsEnableFoldersOpenClose = true
        vim.g.WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
        vim.g.webdevicons_enable_airline_tabline = true
        vim.g.webdevicons_enable_airline_statusline = true

        -- init.lua 顶部或 plugins/init.lua 顶部
        vim.g.WebDevIconsUnicodeDecorateFileNodesExactSymbols = {
          ['.gitignore'] = '',
          ['.gitreview'] = '',
          ['.gitconfig'] = '',
          ['.git'] = '',
          ['.github'] = '',
          ['.config'] = '',
        }

        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
          conf = '',
          cfg = '',
          yml = '',
          xml = '',
          go = '',
          txt = '',
          pdf = '',
          crt = '',
          key = '',
          dockerfile = '',
          proto = '',
          toml = 'ﭨ',
          pem = '',
          svg = 'ﰟ',
          mp4 = 'ﴼ',
          properties = '',
          lock = '',
        }
end

require('lazy').setup({
        spec = {
                {'ryanoasis/vim-devicons',
                        lazy = false,
                        priority = 1000,
                        init = webdevicon_init},
                {'scrooloose/nerdtree',
                        dependencies = {
                                'ryanoasis/vim-devicons',
                        }
                },
                {'NLKNguyen/papercolor-theme'},
                --{'morhetz/gruvbox'},
                {'ellisonleao/gruvbox.nvim'},
                {'sainnhe/gruvbox-material', init = gruvbox_init},
                {'srcery-colors/srcery-vim'},
                {'majutsushi/tagbar'},
                {'Yggdroot/indentLine', },
                {'mhinz/vim-startify',
                        dependencies = {
                                'ryanoasis/vim-devicons',
                        }
                },
                {'frazrepo/vim-rainbow', },
                {'vim-airline/vim-airline', init = airline_config},
                {'vim-airline/vim-airline-themes'},
                {'vim-scripts/buf_it'},
                {'bronson/vim-trailing-whitespace'},
                {'terryma/vim-multiple-cursors'},
                {'tpope/vim-fugitive'},
                {'ctrlpvim/ctrlp.vim',
                        dependencies = {
                                'ryanoasis/vim-devicons',
                        },
                },
                {'Raimondi/delimitMate'},
                {'tiagofumo/vim-nerdtree-syntax-highlight'},
                {'liuchengxu/vim-clap'},
                {'davidhalter/jedi-vim', ft='python'},
                {'dense-analysis/ale',
                        ft = { 'c', 'cpp', 'python', 'rust'},
                },
                {'rust-lang/rust.vim', ft = {'rust'}},
                --{'prabirshrestha/vim-lsp'},
                --{'prabirshrestha/async.vim'},
                --{'prabirshrestha/asyncomplete.vim'},
                --{'prabirshrestha/asyncomplete-lsp.vim'},
                --{'mattn/vim-lsp-settings'},
                {
                        'neovim/nvim-lspconfig',
                        config = lsp_config,
                        ft = { 'c', 'cpp', 'lua', 'python', 'rust'},
                        lazy = true,
                        dependencies =
                        {
                                'hrsh7th/nvim-cmp',
                                        dependencies = {
                                                'hrsh7th/cmp-nvim-lsp',
                                                'L3MON4D3/LuaSnip',
                                        },
                                config = function()
                                        local cmp = require('cmp')
                                        cmp.setup({
                                                snippet = {
                                                        expand = function(args)
                                                                require('luasnip').lsp_expand(args.body)
                                                        end,
                                                },
                                                mapping = cmp.mapping.preset.insert({
                                                        --['<Tab>'] = cmp.mapping.select_next_item(),
                                                        --['<S-Tab>'] = cmp.mapping.select_prev_item(),
                                                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                                }),
                                                sources = cmp.config.sources({
                                                        { name = 'nvim_lsp' },
                                                        --{ name = 'luasnip' },
                                                }),
                                                formatting = {
                                                        fields = { 'abbr', 'menu' },
                                                        --format = function(entry, vim_item)
                                                        --        return vim_item
                                                        --end,
                                                },
                                        })
                                end,
                        }
                }
        },
        root = plug_root_path,
})
-- 启用鼠标支持
vim.opt.mouse = 'a'
-- 设置终端编码
-- vim.opt.termencoding = 'utf-8'
-- 文件格式为 UNIX
--vim.opt.fileformat = 'unix'
-- 文件编码为 UTF-8
--vim.opt.encoding = 'utf-8'
--vim.opt.fileencoding = 'utf-8'
--vim.opt.fileencodings = { 'ucs-bom', 'utf-8', 'cp936', 'gb18030', 'big5', 'euc-jp', 'euc-kr', 'latin1' }
-- 设置中文菜单
vim.opt.langmenu = 'zh_CN'
-- 设置语言环境
vim.env.LANG = 'zh_CN.UTF-8'
vim.opt.cursorline = true
vim.opt.autochdir = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.foldenable = false
vim.opt.undofile = false
vim.opt.autoindent = false
vim.opt.cindent = false
vim.opt.smartindent = false
vim.opt.wrap = false
-- 设置在第80列画线
vim.opt.colorcolumn = {80, 80}
-- 设置状态栏显示模式
vim.opt.laststatus = 2
vim.opt.showmode = false
-- 折叠方法：使用缩进来折叠
vim.opt.foldmethod = 'indent'
-- 打开文件时默认折叠层级为99（实际上就是展开所有折叠）
vim.opt.foldlevelstart = 99
-- 填充字符设置：去掉空行符号，把分隔线字符设置为竖线│
vim.opt.fillchars = { eob = ' ', vert = '│' }
-- 缩进相关设置
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- 关闭基于文件类型的缩进
vim.cmd([[filetype indent off]])
-- 补全选项中去除 preview 弹窗
vim.opt.completeopt:remove('preview')
vim.g.brown = '905532'
vim.g.aqua =  '3AFFDB'
vim.g.blue = '689FB6'
vim.g.darkBlue = '00B2EE'
vim.g.purple = '834F79'
vim.g.lightPurple = '834F79'
vim.g.red = 'AE403F'
vim.g.beige = 'F5C06F'
vim.g.yellow = 'F09F17'
vim.g.orange = 'D4843E'
vim.g.darkOrange = 'F16529'
vim.g.pink = 'CB6F6F'
vim.g.salmon = 'EE6E73'
vim.g.green = '8FAA54'
vim.g.lightGreen = '31B53E'
vim.g.white = 'FFFFFF'
vim.g.rspec_red = 'FE405F'
vim.g.git_orange = 'F54D27'

-- 自动刷新文件
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = 'checktime',
})
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  command = 'checktime',
})

-- 保存前自动去除多余空格
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[%s/\s\+$//e]],
})

-- 不同文件类型设置 tab 缩进规则
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'javascript' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'tex', 'vim', 'rust' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'h', 'go', 'cpp', 'make' },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.expandtab = true
  end,
})

vim.opt.guifont = 'CodeNewRoman Nerd Font:h16'
vim.g.startify_files_number = 40
vim.g.rainbow_active = true

vim.g.indentLine_char='│'
vim.g.indentLine_enabled = true

vim.g.tagbar_width=40
vim.g.tagbar_autofocus = true
vim.g.tagbar_sort = false
vim.g.tagbar_compact = true
vim.g.tagbar_map_showproto = ''
vim.g.tagbar_show_tag_linenumbers = true
vim.g.tagbar_show_data_type = true
vim.g.tagbar_width = 25
vim.g.tagbar_iconchars = {'▸', '▾'}

vim.g.NERDChristmasTree = 0
vim.g.NERDTreeWinSize = 25
vim.g.NERDTreeChDirMode = 2
vim.g.NERDTreeShowHidden = true
vim.g.NERDTreeIgnore = { '\\~$', '\\.pyc$', '\\.swp$' }
vim.g.NERDTreeShowBookmarks = true
vim.g.NERDTreeDirArrowExpandable = '▸'
vim.g.NERDTreeDirArrowCollapsible = '▾'
vim.g.NERDTreeCopyCmd= 'cp -r '
vim.g.NERDTreeStatusline = 'Nerdtree'

vim.g.rustfmt_autosave = true
vim.g.rustfmt_options = '--config max_width=80'
--vim.g.lsp_fold_enabled = false
--vim.g.lsp_diagnostics_enabled = false
--vim.g.lsp_diagnostics_signs_enabled = false
--vim.g.lsp_document_highlight_enabled = true
--vim.g.lsp_document_code_action_signs_enabled = false

vim.g.ale_use_neovim_diagnostics_api = false
vim.g.ale_linters = { rust = { 'cargo' } }
vim.g.ale_virtualtext_cursor = '0'
vim.g.ale_virtualtext_prefix = ' '
vim.g.ale_sign_error = ''
vim.g.ale_sign_warning = ''
vim.g.ale_sign_style_error = ''
vim.g.ale_sign_style_warning = ''
vim.g.ale_echo_msg_format = '%severity% - %s'
vim.g.ale_echo_msg_error_str = ''
vim.g.ale_echo_msg_warning_str = ''
vim.g.ale_echo_cursor = false
vim.g.ale_detail_to_floating_preview = true
vim.g.ale_cursor_detail = true
vim.g.ale_close_preview_on_insert = true
vim.g.ale_rust_cargo_use_check=false
vim.g.ale_rust_cargo_check_tests=true
vim.g.ale_rust_cargo_check_examples=true
vim.g.ale_rust_cargo_default_feature_behavior=('all')
vim.g.ale_rust_cargo_use_clippy=true
vim.g.ale_rust_cargo_clippy_options = '--allow clippy::too_many_arguments --allow clippy::single_component_path_imports --allow clippy::redundant_field_names --allow clippy::enum_variant_names --allow clippy::upper_case_acronyms'
vim.g.ale_python_flake8_options = '--ignore=I201,D103,D104,D100,D103,D105,D101,D102,D107 --import-order-style edited'
vim.g.ale_python_pylint_options = '--disable=C0103,C0114,C0115,C0116,C0123,C0302,D101,D102,D103,D104,D107,R0201,R0902,R0904,R0911,R0912,R0913,R0914,R0915,R1702,R1710,W0212,W0511,W0603,W0621,W0703,W0706'
vim.g.ale_python_auto_pipenv = true
vim.g.ale_python_bandit_auto_pipenv = true
vim.g.ale_python_black_auto_pipenv = true
vim.g.ale_python_flake8_auto_pipenv = true
vim.g.ale_python_flakehell_auto_pipenv = true
vim.g.ale_python_isort_auto_pipenv = true
vim.g.ale_python_mypy_auto_pipenv = true
vim.g.ale_python_prospector_auto_pipenv = true
vim.g.ale_python_pycodestyle_auto_pipenv = true
vim.g.ale_python_pydocstyle_auto_pipenv = true
vim.g.ale_python_pyflakes_auto_pipenv = true
vim.g.ale_python_pylama_auto_pipenv = true
vim.g.ale_python_pylsp_auto_pipenv = true
vim.g.ale_python_pyre_auto_pipenv = true
vim.g.ale_python_pylint_auto_pipenv = true
vim.g.ale_python_pylint_change_directory = true
vim.g.ale_python_pylint_auto_poetry = true

local opts = { noremap=true, silent=true }
if vim.fn.has('gui_running') == 1 then
        vim.opt.guioptions:remove('T')
        vim.g.Tb_MoreThanOne = 1
        vim.opt.guifont = 'CodeNewRoman Nerd Font,Microsoft YaHei:h16'
        vim.keymap.set('n', '<A-d>', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<A-r>', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<F1>', ':enew<CR>',     { silent = true })
        vim.keymap.set('n', '<F2>', ':bdelete!<CR>', { silent = true })
        vim.keymap.set('n', '<F3>', ':Startify<CR>', { silent = true })
else
        -- 终端模式设置
        -- 更推荐设置为 true，而不是旧的 t_Co
        vim.opt.termguicolors = true
        -- srcery colorscheme 相关设置
        vim.g.srcery_bg_passthrough = true
        vim.g.srcery_hard_black_terminal_bg = true
        vim.g.srcery_bold = true
        vim.g.srcery_italic = true
        vim.g.srcery_inverse_matches = true
        vim.g.srcery_inverse_match_paren = true
        vim.g.srcery_italic_types = true
        -- 启动时设置透明背景
        vim.api.nvim_create_autocmd('VimEnter', {
                pattern = '*',
                command = 'highlight Normal guibg=NONE ctermbg=NONE'
        })

        -- 插件相关设置
        vim.g.ctrlp_types = { 'buf', 'fil', 'mru' }
        vim.g.buftabline_show = 2
        vim.g.buftabline_numbers = 2
        vim.g.NERDTreeWinPos = 'right'
        vim.keymap.set('n', '<C-d>', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<S-f>', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
end
vim.opt.background = 'dark'
local colorschemes = {}

if is_nvim_011_or_newer then
        colorschemes = {'PaperColor', 'srcery', 'gruvbox'}
else
        colorschemes = {'PaperColor', 'srcery', 'gruvbox'}
end

math.randomseed(os.time())
local random_index = math.random(1, #colorschemes)
vim.cmd.colorscheme(colorschemes[random_index])

-- 定义 VertSplit 颜色
vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
                vim.api.nvim_set_hl(0, 'VertSplit', { cterm = { bold = true }, ctermfg = 232 })
                vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#121212' })
        end,
})

-- 从上次文件关闭的位置打开
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.keymap.set('n', '<S-Insert>', '"+p', { silent = true })
-- 插入模式下，Shift+Insert 粘贴剪贴板内容
vim.keymap.set('i', '<S-Insert>', '<Esc>"+pa', { silent = true })
-- 清除并重新定义 CursorLine
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })

if vim.g.neovide then
        vim.g.neovide_cursor_vfx_mode = 'torpedo'
end

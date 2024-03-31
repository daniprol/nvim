-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set options and clipboard before starting up lazy.nvim
require('options')

-- Install package manager
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
-- print('Adding lazy to path: ' .. lazypath)
vim.opt.rtp:prepend(lazypath)
-- :lua print(vim.inspect(vim.api.nvim_list_runtime_paths()))
-- :lua print(vim.inspect(vim.opt.runtimepath:get()))
-- USE vim.o to just get variables and print them. Use vim.opt to access other methods in the metatable
-- print('Current run time path: ' .. vim.o.runtimepath)

--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
--
-- NOTE: lazy.nvim doesn't support reloading your conf (source %).
-- When adding "keys" you may need to reopen nvim to apply changes
require('lazy').setup({
    defaults = {
        lazy = false, -- Set to `true to have all plugins lazy-loaded by default
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    -- checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = require('disable_plugins'),
        },
    },
    spec = {
        -- FIST START WITH PLUGINS THAT DO NOT REQUIRE CONFIGURATION
        -- GIT PLUGINS
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',

        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
        'tpope/vim-dotenv', -- Load env file with :Dotenv {file} , :verbose Dotenv
        -- You can pass a range or the whole buffer as a query
        -- :%DB mysql://root@localhost/bazquux
        -- You can also pass a file as input:
        -- :DB mongodb:///test < big_query.js
        'tpope/vim-dadbod',
        {
            'kristijanhusak/vim-dadbod-ui',
            dependencies = { 'tpope/vim-dadbod' },
            -- ft = { 'sql' }, -- Lazy load after specific filetype is opened (plugin will remain opened after that)
            config = function()
                -- vim.g.db_ui_disable_mappings = 1
                vim.g.db_ui_win_position = 'right'
                vim.g.db_ui_use_nerd_fonts = 1
                vim.keymap.set('n', '<leader>db', vim.cmd.DBUIToggle, { desc = 'Toggle [DB] UI' })
            end,
        },
        -- {'kristijanhusak/vim-dadbod-completion'},
        -- dependencies = { 'kristijanhusak/vim-dadbod-ui'},

        -- Allows you to modify the QF list manually (without modifying the source text)
        { 'itchyny/vim-qfedit' },

        -- NOTE: This is where your plugins related to LSP can be installed.
        --  The configuration is done below. Search for lspconfig to find it below.
        {
            -- LSP Configuration & Plugins
            'neovim/nvim-lspconfig',
            dependencies = {
                -- Automatically install LSPs to stdpath for neovim
                { 'williamboman/mason.nvim', config = true }, -- NOTE: config = true means that setup() is already called?
                -- Install servers with: :LspInstall
                -- e.g. :LspInstall python
                'williamboman/mason-lspconfig.nvim',

                -- Useful status updates for LSP
                -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
                { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

                -- Additional lua configuration, makes nvim stuff amazing!
                'folke/neodev.nvim',
            },
        },
        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            opts = {}, -- this is equalent to setup({}) function
        },

        {
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',

                -- Adds LSP completion capabilities
                'hrsh7th/cmp-nvim-lsp',

                -- Adds a number of user-friendly snippets
                'rafamadriz/friendly-snippets',

                -- SQL completions
                'kristijanhusak/vim-dadbod-completion',

                -- Automatic signature_help
                'hrsh7th/cmp-nvim-lsp-signature-help',
            },
        },

        -- Useful plugin to show you pending keybinds.
        -- { 'folke/which-key.nvim', opts = {} },
        {
            -- Adds git related signs to the gutter, as well as utilities for managing changes
            'lewis6991/gitsigns.nvim',
            -- Usefule commands :Gitsigns toggle_current_line_blame
            opts = {
                -- See `:help gitsigns.txt`
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous [H]unk' })
                    vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next [H]unk' })
                    vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
                end,
            },
        },

        {
            -- Set lualine as statusline
            'nvim-lualine/lualine.nvim',
            -- See `:help lualine.txt`
            opts = {
                options = {
                    icons_enabled = true,
                    theme = 'onedark', -- Green colors look better
                    -- theme = 'catppuccin', -- It will pick up the flavor automatically
                    -- theme = vim.g.colors_name,
                    component_separators = '|',
                    section_separators = '',
                },
            },
        },

        {
            -- Add indentation guides even on blank lines
            'lukas-reineke/indent-blankline.nvim',
            -- Enable `lukas-reineke/indent-blankline.nvim`
            -- See `:help indent_blankline.txt`
            main = 'ibl',
            -- opts = {
            --   char = '┊',
            --   show_trailing_blankline_indent = false,
            -- },
        },

        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()

                -- ADD MAPPINGS TO GET VSCODE BEHAVIOR
                -- Toggle comment in current line
                vim.keymap.set('n', '<C-\\>', '<Plug>(comment_toggle_linewise_current)')

                -- Toggle comment in current selection (LINEWISE)
                vim.keymap.set('x', '<C-\\>', '<Plug>(comment_toggle_linewise_visual)')
            end,
        },

        -- Fuzzy Finder (files, lsp, etc)
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',

                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    -- NOTE: If you are having trouble with this installation,
                    --       refer to the README for telescope-fzf-native for more instructions.
                    lazy = false,
                    build = 'make',
                    cond = function()
                        return vim.fn.executable('make') == 1
                    end,
                },
                -- {
                --   'gbrlsnchs/telescope-lsp-handlers.nvim'
                -- },
                -- Replace windowizer with a script like: tmux neww -n $FILE 'nvim $PATH'
                -- Uses Telescope UI for things like: lua vim.lsp.buf.code_action()
                { 'nvim-telescope/telescope-ui-select.nvim' },
            },
        },

        {
            -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            build = ':TSUpdate',
        },

        -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
        --       These are some example plugins that I've included in the kickstart repository.
        --       Uncomment any of the lines below to enable them.
        -- require 'kickstart.plugins.autoformat',
        -- require 'kickstart.plugins.debug',

        -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
        --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
        --    up-to-date with whatever is in the kickstart repo.
        --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
        --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
        { import = 'plugins' },
    },
})

-- [[ Basic Keymaps ]]
require('keymaps')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ timeout = 120 })
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Configure Telescope ]]
require('telescope_conf')

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'tsx', 'typescript', 'vimdoc', 'vim', 'sql', 'regex', 'markdown', 'markdown_inline', 'javascript' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
})

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  Function that is executed when LSP connects to specific buffer
local on_attach = function(client, bufnr)
    if client.name == 'ruff_lsp' then
        client.server_capabilities.hoverProvider = false -- Use PyRight instead
        -- elseif client.name == 'pyright' then
        -- PROBLEM: pyright doesnt have this option!
        -- client.server_capabilities.publishDiagnostics = false
    elseif client.name == 'lua_ls' then
        client.server_capabilities.documentFormattingProvider = false -- In case you want to use stylua with none-ls
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    -- Problem with "organizeImports" is that the file is not saved afterwards
    nmap('<leader>oi', function()
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                only = { 'source.organizeImports' },
                diagnostics = {},
            },
        })
    end, '[O]rganize [I]mports')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- nmap('KK', vim.lsp.buf.signature_help, 'Signature Documentation')

    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP: Signature documentation' })

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    vim.keymap.set({ 'n', 'v' }, '<leader>fo', vim.lsp.buf.format, { desc = '[F][O]rmat file' })
    -- NOTE: you can apply range formatting with 'gq' as well
    -- vim.keymap.set('n', '<leader>fo', function()
    --   vim.lsp.buf.format { async = true }
    -- end, { desc = '[F][O]rmat file' })

    -- Correctly illuminate cmp suggestions
    require('illuminate').on_attach(client)
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- clangd = {},
    -- gopls = {},
    pyright = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                -- diagnosticMode = 'openFilesOnly',
                -- diagnosticMode = 'workspace',
                -- diagnosticMode = 'off', -- This is not even an option
                -- Change diagnostic from "hint" to "warning":
                -- diagnosticSeverityOverrides = {
                --   reportUnusedVariable = "warning", -- or anything
                -- }
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'off',
            },
        },
    },
    -- rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
        Lua = {
            -- diagnostics = { globals = { "vim" } },
            -- format = {
            --   enable = false,
            --   defaultConfig = {
            --     indent_style = 'space',
            --     indent_size = '4',
            --   },
            -- },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- NOTE: to check capabilities of current active LSP:
-- :lua =vim.lsp.get_active_clients()[1].server_capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
-- Mason LSPconfig also adds the commands :LspInstall and :LspUninstall
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            -- handlers = {
            --     ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers['signature_help'], {
            --         border = 'single',
            --         close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
            --     }),
            -- },
        })
    end,
    ['pyright'] = function()
        require('lspconfig')['pyright'].setup({
            capabilities = capabilities,
            -- NOTE: this only disables PyRight's "hints" so you could still have duplicated diagnostics
            -- NOTE: you can also use vim.deepcopy() to clone "capabilities" table
            -- capabilities = (function()
            --     local capabilities = vim.lsp.protocol.make_client_capabilities()
            --     capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            --     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            --     return capabilities
            -- end)(),
            on_attach = on_attach,
            settings = servers['pyright'],
            filetypes = (servers['pyright'] or {}).filetypes,
            -- Turnoff ALL diagnostics and use PyRight only for autocompletion
            handlers = {
                ['textDocument/publishDiagnostics'] = function() end,
            },
            -- Useful :=require('lspconfig')['pyright'].handlers
            -- Also :=require('lspconfig').util.default_config
        })
    end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- ALTERNATIVE: try <C-j> and <C-k> for scrolling
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ALTERNATIVE: try <C-d> and <C-u> for scrolling
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        -- ['<CR>'] = cmp.mapping.confirm {
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = true,
        -- },
        --  NOTE: <Tab> still gives problems in snippets when it shows autocompletion
        --  IDEA: use <CR> to jump to next completion with the snippet
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            -- if cmp.visible() then
            --   cmp.select_prev_item()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'vim-dadbod-completion' },
        { name = 'nvim_lsp_signature_help' },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                -- nvim_lsp = '[LSP]',
                -- vsnip = '[Snippet]',
                ['vim-dadbod-completion'] = '[DB]',
            })[entry.source.name]
            return vim_item
        end,
    },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Clear Quickfix list with :Cclear
vim.api.nvim_create_user_command('Cclear', function(ctx)
    vim.fn.setqflist({})
end, {})

-- Additional utilities:
require('utils')

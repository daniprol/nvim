return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    enabled = true,
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',
        -- 'theHamsta/nvim-dap-virtual-text',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        "nvim-neotest/nvim-nio",
        -- Add your own debuggers here
        'mfussenegger/nvim-dap-python'
    },
    config = function()
        -- TODO: add cmp-dap plugin to get completion in the dap REPL
        local dap = require('dap')
        local dapui = require('dapui')
        -- setup dap config by VsCode launch.json file
        local vscode = require("dap.ext.vscode")
        local json = require("plenary.json")
        vscode.json_decode = function(str)
            return vim.json.decode(json.json_strip_comments(str))
        end

        vscode.load_launchjs()


        require('mason-nvim-dap').setup({
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                'debugpy'
                -- Update this to ensure that you have the debuggers for the langs you want
                -- 'delve',
            },
        })


        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        -- Step one line
        vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
        -- NOTE: <leader>bp is already used to pin buffers
        vim.keymap.set('n', '<leader>s', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>cb', function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end, { desc = 'Debug: Set Breakpoint' })
        vim.keymap.set('n', '<Leader>dl', dap.repl.open, { desc = 'Debug: Open REPL' })
        vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { noremap = true, desc = "Debug: Evaluate" })
        vim.keymap.set("n", "<leader>dt", dapui.toggle, { noremap = true, desc = "Debug: Toggle DAP UI" })
        vim.keymap.set("n", "<leader>dc", dapui.close, { noremap = true, desc = "Debug: Close DAP UI" })
        vim.keymap.set("n", "<leader>do", dapui.open, { noremap = true, desc = "Debug: Open DAP UI" })
        -- Open DAP UI and reset layout
        vim.keymap.set("n", "<leader>dr", function() dapui.open({ reset = true }) end,
            { noremap = true, desc = "Debug: Open DAP UI" })
        -- vim.keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true, desc="Debug: Toggle Harpoon UI"})

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup({
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        })

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
        -- Automatically open the DAP UI when a session is started (place after calling dapui.setup())
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- require('nvim-dap-virtual-text').setup()
        vim.fn.sign_define('DapBreakpoint',
            { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })


        -- /home/daniprol/.local/share/nvim/mason/packages/debugpy/venv/bin/python
        local python_path = table.concat(
            { vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/'):gsub('//+', '/')
        require("dap-python").setup(python_path)
    end,
}

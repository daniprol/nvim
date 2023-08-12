-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
   defaults = {
      mappings = {
         i = {
            ['<Esc>'] = require('telescope.actions').close, -- Close telescope directly
            ['<C-u>'] = false,
            ['<C-d>'] = false,
         },
      },
      file_ignore_patterns = {
         "node_modules",
         "venv"
      },
   },
   -- "strip-cwd-prefix" eliminates "./" from results
   -- pickers = {
   --    find_files = {
   --       find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
   --    },
   -- }
}



-- Enable telescope fzf native, if installed. This must go after require('telescope').setup()
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [B]uffers' })
vim.keymap.set('n', '<leader>/', function()
   -- You can pass additional configuration to telescope to change theme, layout, etc.
   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
   })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- Search for hidden files and files included in the .gitignore as well
vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end,
   { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>pf',
   function() require('telescope.builtin').find_files({ cwd = '~/Projects', hidden = true, no_ignore = true }) end,
   { desc = 'Search ~/[P]rojects [F]iles' })
vim.keymap.set('n', '<leader>pg', function() require('telescope.builtin').live_grep({ cwd = '~/Projects' }) end,
   { desc = 'Search ~/[P]rojects with [G]rep' }) -- NOTE: this is slow. Use fzf-lua instead!
vim.keymap.set('n', '<leader>H', require('telescope.builtin').help_tags, { desc = 'Search [H]elp' })
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
vim.keymap.set('n', '<leader>*', require('telescope.builtin').grep_string,
   { desc = 'Search word under cursor in multiple files' })
vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = 'Search with [G]rep' })
vim.keymap.set('n', '<leader>D', require('telescope.builtin').diagnostics, { desc = 'Search [D]iagnostics' })

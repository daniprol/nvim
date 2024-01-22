local select_one_or_multi = function(prompt_bufnr)
   local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
   local multi = picker:get_multi_selection()
   if not vim.tbl_isempty(multi) then
      require('telescope.actions').close(prompt_bufnr)
      for _, j in pairs(multi) do
         if j.path ~= nil then
            vim.cmd(string.format("%s %s", "edit", j.path))
         end
      end
   else
      require('telescope.actions').select_default(prompt_bufnr)
   end
end

-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
   defaults = {
      mappings = {
         i = {
            ['<Esc>'] = require('telescope.actions').close, -- Close telescope directly
            ["<CR>"] = select_one_or_multi,                 -- Open multiple files at the same time
            ['<C-u>'] = false,
            -- ['<C-d>'] = false,
            ['<c-d>'] = require('telescope.actions').delete_buffer
         },
         n = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
         },
      },
      -- NOTE: this is slow, it is preferred to use a .gitignore file
      -- file_ignore_patterns = {
      --    "node_modules",
      --    "venv",
      --    "__pycache__",
      --    ".git/",
      -- },
   },
   -- "strip-cwd-prefix" eliminates "./" from results
   pickers = {
      find_files = {
         -- find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
         file_ignore_patterns = { ".git/" }
      },
   },
   extensions = {
      -- lsp_handlers = {
      --    code_action = {
      --       telescope = require('telescope.themes').get_dropdown({}),
      --    },
      -- },
      ['ui-select'] = require("telescope.themes").get_dropdown({})
   },
}



-- Enable telescope fzf native, if installed. This must go after require('telescope').setup()
-- pcall(require('telescope').load_extension, 'fzf')
require('telescope').load_extension('fzf')
-- pcall on telescope extension does not work:
-- local ok_fzf, _ = pcall(require, 'fzf-native')
-- local ok_fzf, _ = pcall(require, 'fzf_lib')
-- local ok_fzf = pcall(telescope.load_extension, 'fzf_lib')
-- assert(ok_fzf)

-- require('telescope').load_extension 'lsp_handlers'
require("telescope").load_extension("ui-select")

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
vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files({ hidden = true }) end,
   { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>fa', function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end,
   { desc = 'Search [F]iles [A]ll' })
-- TODO: add commands to find ALL files and grep within ALL files
-- Telescope is slow for large directories use fzf-lua to search in ~/Projets
-- vim.keymap.set('n', '<leader>pf',
--    function() require('telescope.builtin').find_files({ cwd = '~/Projects', hidden = true, no_ignore = true }) end,
--    { desc = 'Search ~/[P]rojects [F]iles' })
-- vim.keymap.set('n', '<leader>pg', function() require('telescope.builtin').live_grep({ cwd = '~/Projects' }) end,
--    { desc = 'Search ~/[P]rojects with [G]rep' })
vim.keymap.set('n', '<leader>H', require('telescope.builtin').help_tags, { desc = 'Search [H]elp' })
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
vim.keymap.set('n', '<leader>*', require('telescope.builtin').grep_string,
   { desc = 'Search word under cursor in multiple files' })
-- live_grep will respect .gitignore by default
vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = 'Search with [G]rep' })
vim.keymap.set('n', '<leader>D', require('telescope.builtin').diagnostics, { desc = 'Search [D]iagnostics' })

return {
  'nvimtools/none-ls.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.ruff,
        -- null_ls.builtins.formatting.ruff.with({
        --   generator_opts = {
        --     command = "ruff",
        --     -- Only fixes [I]mport rule violations
        --     args = { "--select", "I", "--fix", "-e", "-n", "--stdin-filename", "$FILENAME", "-" },
        --     to_stdin = true,
        --   },
        -- }),
        -- null_ls.builtins.formatting.ruff_format,
      },
    }

    -- NOTE: formatting keymaps are already defined in init.lua
  end,

  -- keys = {
  --   { "<leader>n", "<cmd>Neotree toggle<CR>",        desc = "Neotree toggle (cwd)" },
}

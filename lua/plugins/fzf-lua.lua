return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})

    -- :FzfLua fieles cwd=~
    -- :lua require('fzf-lua').files({ cwd = '~' })
    vim.keymap.set("n", "<leader>fs", function() require('fzf-lua').files({ cwd = "~/Projects" }) end,
      { silent = true, desc = "Find [F]ile [S]ystem (~/Projects)" })
    -- vim.keymap.set("n", "<leader>fk", function() require('fzf-lua').keymaps() end,
    --   { silent = true, desc = "Find [F]ile [S]ystem" })
    vim.keymap.set("n", "<leader>fg", function() require('fzf-lua').live_grep({ cwd = "~/Projects" }) end,
      { silent = true, desc = "Find [F]iles [G]rep (~/Projects)" })
    vim.keymap.set("n", "<leader>fa", function() require('fzf-lua').live_grep() end,
      { silent = true, desc = "Search with [G]rep [A]ll" })
  end
}

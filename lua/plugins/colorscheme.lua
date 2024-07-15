return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = true,
    opts = { style = "moon" },
  },
  -- { 'Mofiqul/vscode.nvim', lazy = true, priority = 1000, config = function() vim.cmd 'colorscheme vscode' end },
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000, config = function() vim.cmd("colorscheme carbonfox") end },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    lazy = true,
    enabled = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    -- Set priority and lazy = false to the default colorscheme
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = false },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlinnes = false
          -- underlines = {
          --   errors = { "undercurl" },
          --   hints = { "undercurl" },
          --   warnings = { "undercurl" },
          --   information = { "undercurl" },
          -- },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}

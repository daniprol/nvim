return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  -- config = function()
  --   require("nvim-tree").setup {}
  --
  --   vim.keymap.set('n', '<leader>n', function() vim.cmd('NvimTreeToggle') end, { silent = true })
  -- end,
  keys = { { '<leader>n', function() vim.cmd('NvimTreeToggle') end, silent = true, desc = 'Toggle [N]vim-tree' } },
  -- USEFULE WAY TO REQUIRE CONFIGURATION FROM A TABLE IN ANOTHER LUA MODULE
  -- opts = function()
  --       return require "plugins.configs.nvimtree"
  --     end,
  opts = {
    filters = {
      dotfiles = false,
      custom = { "^.git$", "^node_modules$", "^venv$" },
      -- exclude = { ".git" }, -- DOESN'T WORK
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true, -- DOESN'T WORK
      update_root = false,
    },
    view = {
      adaptive_size = false,
      side = "left",
      width = 30,
      preserve_window_proportions = true,
    },
    git = {
      enable = false,
      ignore = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    -- renderer = {
    --   root_folder_label = false,
    --   highlight_git = false,
    --   highlight_opened_files = "none",
    --
    --   indent_markers = {
    --     enable = false,
    --   },
    --
    --   icons = {
    --     show = {
    --       file = true,
    --       folder = true,
    --       folder_arrow = true,
    --       git = false,
    --     },
    --
    --     glyphs = {
    --       default = "??",
    --       symlink = "?",
    --       folder = {
    --         default = "?",
    --         empty = "?",
    --         empty_open = "?",
    --         open = "?",
    --         symlink = "?",
    --         symlink_open = "?",
    --         arrow_open = "?",
    --         arrow_closed = "?",
    --       },
    --       git = {
    --         unstaged = "?",
    --         staged = "V",
    --         unmerged = "?",
    --         renamed = "?",
    --         untracked = "?",
    --         deleted = "?",
    --         ignored = "?",
    --       },
    --     },
    -- },
    -- },
  }
}

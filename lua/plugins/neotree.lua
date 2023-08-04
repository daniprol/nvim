local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  -- NOTE: when using '<cmd>' it will probably evaluated at startup (LAZY LOAD???)
  keys = {
    { "<leader>n", "<cmd>Neotree toggle<CR>",        desc = "Neotree toggle (cwd)" },
    { "<leader>b", "<cmd>Neotree float buffers<CR>", desc = "Search [B]uffers with Neotree" }
    -- TODO: <leader>b was mapped to add breakpoints somewhere else
  },

  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    close_if_last_window = true, -- Close Neotree if all other windows are closed
    source_selector = {
      winbar = true,
      statusline = false
    },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}

return M

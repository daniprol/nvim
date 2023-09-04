-- tabs, which include filetype icons and close buttons.
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  opts = {
    options = {
      -- Use mini.bufremove to pick the right buffer after closing one
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      -- custom_filter = function(buf_number)
      --   -- This will group buffers that share the same CWD
      --   -- Works great if you open Vim-dadbod-ui in a new tab (:tab DBUI)
      --   -- But it will not work correctly if you open a buffer with fzf-lua
      --   if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
      --     return true
      --   end
      -- end,
      -- diagnostics_indicator = function(_, _, diag)
      --   local icons = require("lazyvim.config").icons.diagnostics
      --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      --     .. (diag.warning and icons.Warn .. diag.warning or "")
      --   return vim.trim(ret)
      -- end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}

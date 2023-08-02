-- buffer remove
return {
  "echasnovski/mini.bufremove",
  -- stylua: ignore
  keys = {
    { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
  },
  config = function()
    require('mini.bufremove').setup()
    -- DEFAULT setup({ ... }) CONFIGURATION
    -- require('mini.bufremove').setup({
    --   -- Whether to set Vim's settings for buffers (allow hidden buffers)
    --   set_vim_settings = true,
    --
    --   -- Whether to disable showing non-error feedback
    --   silent = false,
    -- })
  end
}

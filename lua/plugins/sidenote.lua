-- lua/plugins/sidenote.lua

return {
  -- This is the key for loading a local plugin.
  -- The path must point to the directory containing the plugin's files.
  dir = '/home/daniprol/.config/nvim/sidenote.nvim',

  -- The config function is where you call the plugin's setup function.
  config = function()
    require('sidenote').setup({
      -- You can override any of the default settings here.
      -- For example, let's add 'lua' to the active filetypes
      -- since you are developing a Lua plugin.
      filetypes = { 'markdown', 'txt', 'lua' },

      -- Example of how to change the keymaps:
      keymap = {
        -- create_note = '<leader>sn', -- Changed from <leader>s to avoid conflicts
        delete_note = '<leader>sx',
      },
    })
  end,
}

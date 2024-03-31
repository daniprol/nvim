return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  -- Usefule commands :Gitsigns toggle_current_line_blame
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '[h', require('gitsigns').prev_hunk,
        { buffer = bufnr, desc = 'Go to Previous [H]unk' })
      vim.keymap.set('n', ']h', require('gitsigns').next_hunk,
        { buffer = bufnr, desc = 'Go to Next [H]unk' })
      vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = '[P]review [H]unk' })

      local function toggle_difflines()
        require('gitsigns').toggle_linehl()
        require('gitsigns').toggle_deleted()
      end

      vim.keymap.set("n", "<leader>gt", toggle_difflines,
        { buffer = bufnr, desc = "Toggle [G]it [T]racked lines" })
      -- NOTE: if "trouble" this will open trouble instead of the quickfix list
      vim.keymap.set("n", "<leader>gq", require('gitsigns').setqflist,
        { buffer = bufnr, desc = "Set [G]it [Q]uick fix list" })
    end,
  },
}

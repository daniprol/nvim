return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gs', function() vim.cmd('vert Git') end, desc = 'Open [G]it [S]tatus in vertical split' },
    { '<leader>gv', ':Gvdiffsplit ',                    desc = 'Open [G]it [V]ertical diff split' }
  },
  -- Settings for default split size:
  config = function()
    -- :vertical G
    -- vim.api.nvim_create_user_command("Gs", function()
    --   vim.cmd("vertical G")
    -- end, { desc = 'Open [G]it [S]tatus in vertical split' })
    -- Change default size of split:
    vim.g.fugitive_status_vertical = 30

    -- Add keymap for git blame
    -- vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { silent = true, desc = 'Git [B]lame' })
    --
    vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<cr>', { silent = true, desc = 'Git [D]iff' })
    --
    vim.keymap.set('n', '<leader>gl', function() vim.cmd('Git log --oneline') end,
      { silent = true, desc = 'Git [L]og oneline' })

    -- ALTERNATIVE: instead of using 2 and 3 use HEAD and OTHER
    vim.keymap.set('n', 'gh', '<cmd>diffget //2<cr>', { silent = true, desc = 'Git diffget HEAD (//2)' })
    vim.keymap.set('n', 'gl', '<cmd>diffget //3<cr>', { silent = true, desc = 'Git diffget OTHER (//3)' })
  end

}

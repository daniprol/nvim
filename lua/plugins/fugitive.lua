return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gv', function() vim.cmd('vert Git | wincmd L | vert resize -65') end, desc = 'Open [G]it status [V]ertical split' },
    { '<leader>gs', function() vim.cmd('Git | wincmd J | resize -10') end,           desc = 'Open [G]it status Hori[S]ontal split' }
  },
  -- Settings for default split size:
  config = function()
    -- :vertical G
    -- vim.api.nvim_create_user_command("Gs", function()
    --   vim.cmd("vertical G")
    -- end, { desc = 'Open [G]it [S]tatus in vertical split' })

    -- Add keymap for git blame
    -- vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { silent = true, desc = 'Git [B]lame' })
    --
    vim.keymap.set('n', '<leader>gl', function() vim.cmd('Git log --oneline') end,
      { silent = true, desc = 'Git [L]og oneline' })

    -- ALTERNATIVE: instead of using 2 and 3 use HEAD and OTHER
    vim.keymap.set('n', 'gh', '<cmd>diffget //2<cr>', { silent = true, desc = 'Git diffget HEAD (//2)' })
    vim.keymap.set('n', 'gl', '<cmd>diffget //3<cr>', { silent = true, desc = 'Git diffget OTHER (//3)' })
  end

}

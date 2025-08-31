return {
  'tpope/vim-fugitive',
  -- enabled = false,
  -- lazy = false,
  -- Use keys only to load the plugin when a keymap is used!
  -- keys = { },

  -- This will run like require('fugitive').setup(opts) automatically, no need to use config = function() ... end
  -- opts = {},
  config = function()
    vim.keymap.set('n', '<leader>gv', function() vim.cmd('vert Git | wincmd L | vert resize -65') end,
      { desc = 'Open [G]it status [V]ertical split' })
    vim.keymap.set('n', '<leader>gs', function() vim.cmd('Git | wincmd J | resize -10') end,
      { desc = 'Open [G]it status Hori[S]ontal split' })
    vim.keymap.set('n', '<leader>gl', function() vim.cmd('Git log --oneline') end,
      { silent = true, desc = 'Git [L]og oneline' })
    -- ALTERNATIVE: instead of using 2 and 3 use HEAD and OTHER
    -- vim.keymap.set('n', 'gh', '<cmd>diffget //2<cr>', { silent = true, desc = 'Git diffget HEAD (//2)' })
    -- vim.keymap.set('n', 'gl', '<cmd>diffget //3<cr>', { silent = true, desc = 'Git diffget OTHER (//3)' })
    vim.keymap.set('n', '<leader>go', '<cmd>diffget LOCAL<cr>',
      { silent = true, desc = 'Git diff[G]et [O]urs (LOCAL //2)' })
    vim.keymap.set('n', '<leader>gb', '<cmd>diffget BASE<cr>',
      { silent = true, desc = 'Git diff[G]et [B]ase (BASE //1)' })
    vim.keymap.set('n', '<leader>gt', '<cmd>diffget REMOTE<cr>',
      { silent = true, desc = 'Git diff[G]et [T]heirs (REMOTE //3)' })
    -- NOTE: LOCAL, BASE and REMOTE will only be defined when using mergetool
    -- You can use //1, //2 and //3 for a normal 3-way split diff.
    -- Or use "d2o" and "d3o" to obtain a hunk from either side
    --
    -- NOTE: use :G mergetool or :G difftool to open the mergetool or difftool with conflicts


    -- :vertical G
    -- vim.api.nvim_create_user_command("Gs", function()
    --   vim.cmd("vertical G")
    -- end, { desc = 'Open [G]it [S]tatus in vertical split' })

    -- Add keymap for git blame
    -- vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { silent = true, desc = 'Git [B]lame' })
    --
  end


}

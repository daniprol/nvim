return {
  'tpope/vim-fugitive',
  config = function()
    -- :vertical G
    vim.api.nvim_create_user_command("Gs", function()
      vim.cmd("vertical G")
    end, { desc = 'Open [G]it [S]tatus in vertical split' })
  end

}

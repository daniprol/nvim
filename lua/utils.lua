-- Redirect output from lua command to new buffer:
-- Example: `:Redir lua=vim.tbl_keys(package.loaded)`
vim.api.nvim_create_user_command('Redir', function(ctx)
   local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })
   -- ':new' == ':split' + ':enew'  ==> Creates empty buffer in split
   -- vim.cmd('new')
   -- Use `:enew` better
   vim.cmd('enew')
   -- `enew`gives problems when current buffer is unsaved and hidden=false
   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
   vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })

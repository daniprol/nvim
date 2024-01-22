-- Redirect output from lua command to new buffer:
-- Example: `:Redir lua=vim.tbl_keys(package.loaded)`
vim.api.nvim_create_user_command('Redir', function(ctx)
   local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })
   -- ':new' == ':split' + ':enew'  ==> Creates empty buffer in split
   -- vim.cmd('new')
   -- Use `:enew` better
   vim.cmd 'enew'
   -- `enew`gives problems when current buffer is unsaved and hidden=false
   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
   vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })

-- Show LSP server capabilities:

vim.api.nvim_create_user_command('LspCapabilities', function()
   local curBuf = vim.api.nvim_get_current_buf()
   local clients = vim.lsp.get_active_clients { bufnr = curBuf }

   for _, client in pairs(clients) do
      if client.name ~= 'null-ls' then
         local capAsList = {}
         for key, value in pairs(client.server_capabilities) do
            if value and key:find 'Provider' then
               local capability = key:gsub('Provider$', '')
               table.insert(capAsList, '- ' .. capability)
            end
         end
         table.sort(capAsList) -- sorts alphabetically
         local msg = '# ' .. client.name .. '\n' .. table.concat(capAsList, '\n')
         vim.notify(msg, 'trace', {
            on_open = function(win)
               local buf = vim.api.nvim_win_get_buf(win)
               vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
            end,
            timeout = 14000,
         })

         -- Sets register '+' with entire capabilities table
         -- vim.fn.setreg('+', 'Capabilities = ' .. vim.inspect(client.server_capabilities))
      end
   end
end, {})

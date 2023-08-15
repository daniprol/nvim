-- vim.api.nvim_del_user_command('Say')

local function myfunc(opts)
   print(opts['name'])
   print(vim.inspect(opts.fargs))
end

vim.api.nvim_create_user_command('Say', myfunc, { nargs = "*" })

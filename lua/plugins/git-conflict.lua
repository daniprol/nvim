return {
  'akinsho/git-conflict.nvim',
  version = "*",
  -- enabled = false,
  config = function()
    local disabled = false
    require('git-conflict').setup({
      -- default_mappings = disabled, -- disable buffer local mapping created by this plugin
      default_mappings = {
        ours = 'o',
        theirs = 't',
        none = '0',
        both = 'b',
        base = 'v', -- TODO: check that it works
        next = 'n', -- NOT WORKING
        prev = 'p',
      },
      default_commands = true,     -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = 'copen',       -- command or function to open the conflicts list
      highlights = {               -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    })

    if not disabled then
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          local filename = vim.fn.expand('%')
          vim.notify(filename .. ' has ' .. require("git-conflict").conflict_count() .. ' conflicts', 'info', {
            title = 'Git Conflict Detected',
            timeout = 5000
          })
          -- vim.keymap.set('n', 'cww', function()
          --   engage.conflict_buster()
          --   create_buffer_local_mappings()
          -- end)
          vim.keymap.set("n", "<leader>mq", vim.cmd.GitConflictListQf,
            { desc = "Add conflict [M]arkers to [Q]uickfix list" })
        end
      })
    end
  end
}

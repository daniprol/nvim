-- Add current buffer to DBUI for .sql files
vim.keymap.set("n", "<leader>ab", vim.cmd.DBUIFindBuffer,
	{ buffer = 0, desc = "[A]ssign current buffer to a DB connection" })

-- NOTE: this could conflict with lazy.nvim plugins being loaded
-- ftplugins are loaded where the buffer is opened.
-- If you get a conflict a specific plugin maybe you could add
-- event = { “BufReadPre”, “BufNewFile” } to that plugin configuration so it loads before ftplugin

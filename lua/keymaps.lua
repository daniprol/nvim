-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', 'jk', "<Esc>", { silent = true })

-- Unindent with <S-Tab>
vim.keymap.set('i', '<S-Tab>', "<C-d>", { silent = true })

-- Move between windows
vim.keymap.set('n', '<leader>h', '<C-w>h', { silent = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { silent = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { silent = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { silent = true })

-- Move between tabs
vim.keymap.set('n', '<S-l>', function() vim.cmd.bnext() end, { silent = true })
vim.keymap.set('n', '<S-h>', function() vim.cmd.bprevious() end, { silent = true })
-- TODO: add mapping to :bfirst and :blast

-- Resize splits
vim.keymap.set('n', '<C-right>', function() vim.cmd('vertical resize +5<cr>') end, { silent = true })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -5<cr>', { silent = true })
vim.keymap.set('n', '<C-up>', '<cmd>horizontal resize -5<cr>', { silent = true })
vim.keymap.set('n', '<C-down>', '<cmd>horizontal resize +5<cr>', { silent = true })


-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Move to the beggining of the wrapped line and not the full one
vim.keymap.set('n', '^', 'g^', { silent = true })
vim.keymap.set('n', '0', 'g0', { silent = true })

-- Insert space after current character
vim.keymap.set('n', '<leader><space>', 'a<Space><esc>h', { silent = true })

-- Do not include whitespace and \n characters when in visual mode
vim.keymap.set('x', '$', 'g_', { silent = true })

-- Yank from current cursor position until end of line just like in D and C
-- vim.keymap.set('n', 'Y', 'y$', { silent = true }) -- ALREADY INCLUDED IN SOME PLUGIN

-- Add lines above/below
vim.keymap.set('n', 'zk', function() vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+") end, { silent = true })
vim.keymap.set('n', 'zj', function() vim.cmd("put =repeat(nr2char(10), v:count1)|silent ']-") end, { silent = true })

-- Do not exit visual mode when indenting selection
-- NOTE: xmap adds mapping only to VISUAL MODE (and not to SELECT mode)
-- vim.keymap.set('x', '<', '<gv', { silent = false })
-- vim.keymap.set('x', '>', '>gv', { silent = false })

-- Edit init.lua
vim.keymap.set('n', '<F1>', '<cmd>e ~/.config/nvim/init.lua<cr>', { silent = false })

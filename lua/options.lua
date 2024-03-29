-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- vim.wo means "Windows options"
vim.o.hlsearch = false -- Highlight all matches when searching

vim.o.pumheight = 15
-- vim.wo.number = true -- WHY WINDOW OPTION HERE???
-- vim.wo.relativenumber = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a' -- Enable mouse
vim.o.clipboard = 'unnamedplus' -- Sync with OS clipboard (:help clipboard)
vim.o.breakindent = true
vim.o.undofile = true -- Save undo history (default undodir: ~/.local/state/nvim/undo )
vim.o.ignorecase = true
vim.o.smartcase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.wo.signcolumn = 'yes' -- I guess signcolumn is used by gitsigns?
vim.o.updatetime = 250 -- Reduce ms to wait for trigger an event
vim.o.timeoutlen = 300
-- Better completion:
--  menuone: shows menu even when there is only 1 match
--  noselect: no option is selected by default in the completion menu
--  noinsert: no options is inserted unless user selects it (by default <CR> enters first option)
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.termguicolors = true -- 24-bit RGB color for the terminal

-- vim.o.swapfile = false -- Don't use swapfile
-- vim.o.showmatch = true        -- Highlight matching parenthesis
-- vim.o.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
vim.o.colorcolumn = '100' -- Line lenght marker at 80 columns
vim.o.splitright = true -- Vertical split to the right
vim.o.splitbelow = true -- Horizontal split to the bottom
-- vim.o.linebreak = true        -- Wrap on word boundary
-- vim.o.laststatus=3            -- Set global statusline
-- vim.o.expandtab = true        -- Use spaces instead of tabs
-- vim.o.shiftwidth = 4          -- Shift 4 spaces when tab
-- vim.o.tabstop = 4             -- 1 tab == 4 spaces
-- vim.o.smartindent = true      -- Autoindent new lines
vim.opt.scrolloff = 3

-- vim.o.hidden = true           -- Enable background buffers
-- vim.o.history = 100           -- Remember N lines in history
-- vim.o.lazyredraw = true       -- Faster scrolling
-- vim.o.synmaxcol = 240         -- Max column for syntax highlight

-- HIGHTLIGHT OPTIONS FOR INDENT-BLANKLINE PLUGIN
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#45475a gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineChar guifg=#00FF00 gui=nocombine]] -- Default value
-- vim.cmd [[highlight IndentBlanklineChar guifg=#ffe6e6 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#ffe6e6 gui=nocombine]]

-- LINUX CLIPBOARD
if vim.fn.has 'unix' == 1 then
  vim.o.clipboard = 'unnamedplus'
  -- This doesnt include 'unnamed'
end

-- WINDOWS CLIPBOARD
if vim.fn.has 'win32' == 1 then
  vim.o.clipboard = { 'unnamed', 'unnamedplus' }
end

-- WSL CLIPBOARD
if vim.fn.has 'wsl' == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = true,
  }
end

-- ALTERNATIVE 1: USE WIN32YANK
-- `scoop install win32yank`
-- vim.api.nvim_exec(
--   [[
--   let g:clipboard = {
--   \ 'name': 'win32yank-wsl',
--   \   'copy': {
--   \      '+': 'win32yank.exe -i --crlf',
--   \      '*': 'win32yank.exe -i --crlf',
--   \    },
--   \   'paste': {
--   \      '+': 'win32yank.exe -o --lf',
--   \      '*': 'win32yank.exe -o --lf',
--   \   },
--   \   'cache_enabled': 0,
--   \ }
-- ]],
--   true
-- )

-- File extensions to ignore when performing TAB completion, functions like glob(), vimgrep, ...
vim.opt.wildignore = {
  '*.o',
  '*.obj,*~',
  '*.git*',
  '*.meteor*',
  '*vim/backups*',
  '*sass-cache*',
  '*mypy_cache*',
  '*__pycache__*',
  '*cache*',
  '*logs*',
  '*node_modules*',
  '**/node_modules/**',
  '*DS_Store*',
  '*venv*',
  '**/venv/**',
  '*venv*',
  '*.gem',
  'log/**',
  'tmp/**',
}

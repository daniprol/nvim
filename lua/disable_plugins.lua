-- THIS FILE NEEDS TO BE REQUIRED: require('disabled_plugins')
-- -- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "tohtml",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}


-- for _, plugin in pairs(disabled_built_ins) do
--    vim.g["loaded_" .. plugin] = 1
-- end

return disabled_built_ins

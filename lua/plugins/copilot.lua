return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	-- opts = {
	--   suggestion = { enabled = false },
	--   panel = { enabled = false },
	--   filetypes = {
	--     markdown = true,
	--     help = true,
	--   },
	-- },
	event = "InsertEnter",
	config = function()
		require('copilot').setup({
			-- Open panel with all suggestions
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					-- jump_prev = "<M-,>",
					-- jump_next = "<M-.>",
					-- accept = "<CR>",
					jump_prev = "<C-p>",
					jump_next = "<C-n>",
					accept = "<C-y>",
					refresh = "gr",
					-- open = "<leader>cp" -- In insert mode
					open = "<M-p>" -- [p]anel
				},

				layout = {
					position = "right", -- bottom | top | left | right
					ratio = 0.4
				},
			},
			--  Inline suggestions
			suggestion = {
				enabled = true,
				auto_trigger = true, -- To show suggestions when entering insert mode
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					-- next = "<M-]>",
					-- prev = "<M-[>",
					-- next = "<C-,>",
					-- prev = "<C-.>",
					next = "<M-.>",
					prev = "<M-,>",
					-- dismiss = "<C-]>",
					dismiss = "<M-k>", -- Alt-k (kill)
				},
			},
			filetypes = {
				-- yaml = false,
				-- markdown = false,
				help = false,
				-- gitcommit = false,
				-- gitrebase = false,
				-- hgcommit = false,
				-- svn = false,
				-- cvs = false,
				["."] = false,
			},
			copilot_node_command = 'node', -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})
	end,
}
-- 	{
-- 	"github/copilot.vim",
-- 	setup = function()
-- 		-- Add local folders to improve copilot experience
-- 		vim.g.copilot_workspace_folders = { "~/Projects" }
--
-- 		-- Change the default keymap for completion
-- 		-- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
-- 		--   expr = true,
-- 		--   replace_keycodes = false
-- 		-- })
-- 		-- vim.g.copilot_no_tab_map = true
-- 		--
-- 		-- Accept ONE WORD of the entire suggestion (FIX: NOT WORKING CURRENTLY)
-- 		-- vim.keymap.set("i", "<M-L>", "<Plug>(copilot-accept-word)", { noremap = false })
--
-- 		-- Prev/Next suggestion (DEFAULT: <Alt-[> and <Alt-]>)
-- 		-- vim.keymap.set("i", "<C-H>", "<Plug>(copilot-next)", { noremap = false })
-- 		-- vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)", { noremap = false })
-- 	end,
-- }

return {
	"github/copilot.vim",
	setup = function()
		-- Add local folders to improve copilot experience
		vim.g.copilot_workspace_folders = { "~/Projects" }

		-- Change the default keymap for completion
		-- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
		--   expr = true,
		--   replace_keycodes = false
		-- })
		-- vim.g.copilot_no_tab_map = true
		--
		-- Accept ONE WORD of the entire suggestion (FIX: NOT WORKING CURRENTLY)
		-- vim.keymap.set("i", "<M-L>", "<Plug>(copilot-accept-word)", { noremap = false })

		-- Prev/Next suggestion (DEFAULT: <Alt-[> and <Alt-]>)
		-- vim.keymap.set("i", "<C-H>", "<Plug>(copilot-next)", { noremap = false })
		-- vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)", { noremap = false })
	end,
}

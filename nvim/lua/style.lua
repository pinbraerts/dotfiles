function RestoreTheme()
	vim.cmd.set("background=dark")
	vim.cmd.colorscheme('tokyonight')
	vim.g.airline_theme = 'zenburn'
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
end

RestoreTheme()
vim.keymap.set("n", "<leader>z", RestoreTheme)

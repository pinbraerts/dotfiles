local languages = { 'rust', 'c', 'cpp', 'python', 'lua', 'cuda', 'tex', 'vimdoc', 'vimscript' }
if vim.fn.has 'win32' then
    require 'nvim-treesitter.install'.compilers = { 'cl.exe' }
end
require 'nvim-treesitter.configs'.setup {
	enable = true,

	auto_install = false,

	highlight = {
		enable = languages,
		disable = false,

		additional_vim_regex_highlighting = false,
	},

	indent = { enable = languages },

	incremental_selection = { enable = languages },
}

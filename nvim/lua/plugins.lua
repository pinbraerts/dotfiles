local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lsp_filetypes = { 'lua', 'python', 'c', 'cpp', 'rust', 'powershell' }
local debuggable_filetypes = { 'python', 'c', 'cpp', 'rust' }

require 'lazy'.setup {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				globalstatus = true,
				section_separators = { left = '', right = '' },
				-- component_separators = { left = '', right = '' },
				component_separators = { left = '|', right = '|' },
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },
				lualine_c = {
					{
						'buffers',
						icons_enabled = false,
						section_separators = { left = '' },
						component_separators = { left = '' },
						mode = 2,
						symbols = {
							alternate_file = '',
						},
					},
				},
				lualine_x = { 'diff', 'diagnostics', },
				lualine_y = { 'filetype', 'fileformat', 'encoding', },
				lualine_z = { 'progress', 'location', },
			},
		},
		lazy = false,
		keys = {
			{ 'g1', '<cmd>LualineBuffersJump 1<cr>', silent = true, desc = 'Jump to buffer 1', },
			{ 'g2', '<cmd>LualineBuffersJump 2<cr>', silent = true, desc = 'Jump to buffer 2', },
			{ 'g3', '<cmd>LualineBuffersJump 3<cr>', silent = true, desc = 'Jump to buffer 3', },
			{ 'g4', '<cmd>LualineBuffersJump 4<cr>', silent = true, desc = 'Jump to buffer 4', },
			{ 'g5', '<cmd>LualineBuffersJump 5<cr>', silent = true, desc = 'Jump to buffer 5', },
			{ 'g6', '<cmd>LualineBuffersJump 6<cr>', silent = true, desc = 'Jump to buffer 6', },
			{ 'g7', '<cmd>LualineBuffersJump 7<cr>', silent = true, desc = 'Jump to buffer 7', },
			{ 'g8', '<cmd>LualineBuffersJump 8<cr>', silent = true, desc = 'Jump to buffer 8', },
			{ 'g9', '<cmd>LualineBuffersJump 9<cr>', silent = true, desc = 'Jump to buffer 9', },
		},
	},

	{
		'EdenEast/nightfox.nvim',
		config = function()
			vim.cmd.colorscheme('nightfox')
		end,
	},

	'folke/tokyonight.nvim',
	{
		'mtdl9/vim-log-highlighting',
		lazy = true,
		ft = 'log',
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		lazy = true,
		ft = { 'rust', 'c', 'cpp', 'python', 'lua', 'cuda', 'vimdoc', 'html', 'css', 'javascript' },
		build = ':TSUpdate',
		config = function ()
			require 'treesitter_setup'
		end,
	},

	{
		'numToStr/Comment.nvim',
		config = function ()
			require 'Comment'.setup {
				padding = true,
				sticky = true,
				toggler = {
					line = 'gc',
				},
				mappings = {
					basic = true,
					extra = false,
				},
			}
		end,
	},

	-- 'pinbraerts/shell.vim',
	'tpope/vim-fugitive',

	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require 'gitsigns_setup'
		end,
	},

	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function ()
			require 'telescope_setup'
		end,
	},

	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		config = function()
			local tf = require('telescope').load_extension('file_browser')
			vim.keymap.set('n', '<leader>fb', tf.file_browser, { desc = '[F]ile [b]rowser' })
		end,
	},

	{
		'nvim-telescope/telescope-symbols.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		config = function()
			local ts = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ts', ts.symbols, { desc = 'Open unicode symbols picker' })
			vim.keymap.set('i', '<c-s>', ts.symbols, { desc = 'Open unicode symbols picker' })
		end,
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
		},
		ft = lsp_filetypes,
		lazy = true,
		config = function ()
			require 'lsp_setup'
		end,
		keys = {
			{ 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', silent = true, desc = 'Switch beetween source and header files by clangd', },
		},
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
		},
		ft = lsp_filetypes,
		lazy = true,
		config = function()
			require 'completion_setup'
		end,
	},

	{
		'mfussenegger/nvim-dap',
		lazy = true,
		ft = debuggable_filetypes,
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'simrat39/rust-tools.nvim',
		},
		config = function ()
			require 'debugging'
		end,
	},

	{
		'nvim-telescope/telescope-dap.nvim',
		lazy = true,
		ft = debuggable_filetypes,
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'mfussenegger/nvim-dap',
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			local td = require('telescope').load_extension('dap')
			vim.keymap.set('n', '<leader>db', td.list_breakpoints, { desc = '[L]ist [d]ebug [b]reakpoints' })
			vim.keymap.set('n', '<leader>dd', td.configurations, { desc = '[L]ist [d]ebug [c]onfigurations' })
			vim.keymap.set('n', '<leader>df', td.frames, { desc = '[List] [d]ebug [f]rames' })
			vim.keymap.set('n', '<leader>dv', td.variables, { desc = '[L]ist [d]ebug [v]ariables' })
		end,
	},

}

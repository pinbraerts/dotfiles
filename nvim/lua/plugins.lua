vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'nvim-lua/plenary.nvim'
	use 'wbthomason/packer.nvim'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	use 'preservim/nerdcommenter'
	use 'EdenEast/nightfox.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'mtdl9/vim-log-highlighting'
	use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'tpope/vim-fugitive'
	use 'lewis6991/gitsigns.nvim'
	use 'mfussenegger/nvim-dap'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim' } },
	}
	use {
		'nvim-telescope/telescope-dap.nvim',
		requires = {
			'nvim-telescope/telescope.nvim',
			'mfussenegger/nvim-dap',
			'nvim-treesitter/nvim-treesitter',
		}
	}
end)

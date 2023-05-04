vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	use 'preservim/nerdcommenter'
	use 'EdenEast/nightfox.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'mtdl9/vim-log-highlighting'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'tpope/vim-fugitive'
	use 'lewis6991/gitsigns.nvim'
end)

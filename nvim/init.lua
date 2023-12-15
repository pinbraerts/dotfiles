local config = vim.fn.stdpath('config')
local vimrc = config .. '/../.vimrc'
if vim.fn.filereadable(vimrc) ~= 0 then
	vim.cmd.source(vimrc)
end
require 'plugins'
require 'style'
require 'remap'
require 'terminal_setup'
vim.o.cmdheight = 0


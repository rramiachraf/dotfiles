-- PACKER SETUP
local packer = require('packer')

packer.startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons', opt = true}} 
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  use 'EdenEast/nightfox.nvim'
  use {'fatih/vim-go', ft = 'go'}
end)

--[[
   _____  ____   _   _  ______  _____  _____ 
  / ____|/ __ \ | \ | ||  ____||_   _|/ ____|
 | |    | |  | ||  \| || |__     | | | |  __ 
 | |    | |  | || . ` ||  __|    | | | | |_ |
 | |____| |__| || |\  || |      _| |_| |__| |
  \_____|\____/ |_| \_||_|     |_____|\_____|
--]]

local lualine = require "lualine"
local tree = require "nvim-tree"
local bufferline = require "bufferline"
local nightfox = require "nightfox"
local map = vim.keymap.set

-- OPTIONS
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.showmode = false
vim.opt.fillchars = "eob: "
vim.opt.termguicolors = true

-- COLOR SCHEME
nightfox.setup {
	options = {
		styles = {
			comments = "italic",
			keywords = "bold"
		}
	}
}

vim.cmd "colorscheme duskfox"

-- FILE EXPLORER
tree.setup {
	open_on_setup_file = true,
	open_on_tab = true,
	view = {
		width = 25,
	}
}

map("n", "<C-a>", tree.toggle)

-- STATUSLINE
lualine.setup()

-- TABS
bufferline.setup {
	options = {
		buffer_close_icon = "",
		close_icon = "",
		offsets = { {filetype = "NvimTree"} }
	}
}

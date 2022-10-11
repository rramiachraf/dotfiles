-- PACKER SETUP
local packer = require('packer')

packer.startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua' 
  use {'akinsho/bufferline.nvim', tag = "v2.*"}
  use 'EdenEast/nightfox.nvim'
  use 'windwp/nvim-autopairs'
  use 'vimwiki/vimwiki'
  use {
	  'prettier/vim-prettier', 
	  ft = {'javascript', 'json', 'typescript', 'prisma', 'css', 'scss', 'html', 'svelte', 'yaml'},
	  run = "yarn install --frozen-lockfile --production"
  }
  use 'neovim/nvim-lspconfig'
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
local autopairs = require "nvim-autopairs"
local lsp = require "lspconfig"
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

-- VIM WIKI
vim.cmd "set nocompatible"
vim.cmd "filetype plugin on"
vim.cmd "syntax on"

-- FILE EXPLORER
tree.setup {
	open_on_setup_file = true,
	open_on_tab = true,
	view = {
		width = 25,
	}
}

map("n", "tt", tree.toggle)
map("n", "tf", tree.focus)

-- AUTOPAIRS
autopairs.setup()

-- MAPPINGS
map("i", "ii", function()
	vim.cmd "stopinsert"
end)

-- STATUSLINE
lualine.setup()

-- TABS
bufferline.setup {
	options = {
		buffer_close_icon = "",
		close_icon = "",
		diagnostics = "nvim_lsp",
		offsets = { {filetype = "NvimTree"} }
	}
}

map("n", "gt", function()
	vim.cmd "bnext"
end)

-- LSP
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- closes preview automatically
  vim.cmd "autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif"
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'ga', vim.lsp.buf.code_action, bufopts)
  map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lsp.gopls.setup {
	on_attach = on_attach
}

lsp.tsserver.setup{
	on_attach = on_attach
}

lsp.tailwindcss.setup {
	on_attach = on_attach
}

lsp.prismals.setup {
	on_attach = on_attach
}

lsp.ccls.setup {
	on_attach = on_attach
}

-- FORMATING
map('n', '<C-p>', function()
	vim.cmd "Prettier"
end)

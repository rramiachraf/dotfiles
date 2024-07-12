-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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


require("lazy").setup({
	{'nvim-tree/nvim-web-devicons'},
	{'nvim-lualine/lualine.nvim'},
	{'kyazdani42/nvim-tree.lua'},
	{'EdenEast/nightfox.nvim'},
	{'windwp/nvim-autopairs'},
	{'neovim/nvim-lspconfig'},
	{
		'prettier/vim-prettier', 
		ft = {'javascript', 'json', 'typescript', 'prisma', 'css', 'scss', 'html', 'svelte', 'yaml', 'graphql', 'typescriptreact'},
		build = "yarn install --frozen-lockfile --production"
	},
	{
		'akinsho/bufferline.nvim',
		version = "v4.*"
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	}
})

local lualine = require "lualine"
local tree = require "nvim-tree"
local treeApi = require "nvim-tree.api"
local bufferline = require "bufferline"
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
vim.opt.autoread = true

require("nightfox").setup {
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			functions = "bold"
		}
	}
}

vim.cmd "colorscheme nightfox"

-- VIM WIKI
vim.cmd "set nocompatible"
vim.cmd "filetype plugin on"
vim.cmd "syntax on"

-- SVELTE
vim.cmd "let g:svelte_preprocessor_tags = [{ 'name': 'ts', 'tag': 'script', 'as': 'typescript' }]"
vim.cmd "let g:svelte_preprocessors = ['ts']"

-- FILE EXPLORER
tree.setup {
	open_on_tab = true,
	view = {
		width = 30,
	}
}

treeApi.tree.open()

map("n", "tt", treeApi.tree.toggle)
map("n", "tf", treeApi.tree.focus)


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

vim.filetype.add({ extension = { templ = "templ" } })

local servers = { 'gopls', 'tsserver', 'tailwindcss', 'prismals', 'cssls', 'svelte', 'templ', 'html', 'graphql' }
for _, server in ipairs(servers) do
	lsp[server].setup({
		on_attach = on_attach
	})
end 

-- FORMATING
map('n', '<C-p>', function()
	vim.cmd "Prettier"
end)

require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

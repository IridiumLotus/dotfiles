-- Bootstrap Lazy.nvim
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

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lazy.nvim setup
require("lazy").setup({
    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    
    -- Autocompletion plugins
    { "hrsh7th/nvim-cmp" },  -- Completion plugin
    { "hrsh7th/cmp-nvim-lsp" },  -- LSP source for nvim-cmp
    { "hrsh7th/cmp-buffer" }, -- Buffer completions

    -- File explorer
    { "kyazdani42/nvim-tree.lua" },
    { "kyazdani42/nvim-web-devicons" }, -- Icons for nvim-tree

    -- Dashboard for Neovim with custom ASCII art
    { "glepnir/dashboard-nvim" },

    -- Catppuccin theme
    { "catppuccin/nvim", as = "catppuccin" },
})

-- Configure theme
require("catppuccin").setup({
    flavour = "mocha",  -- Choose between latte, frappe, macchiato, mocha
    transparent_background = false, -- Keep the background opaque
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
    },
})
vim.cmd("colorscheme catppuccin")

-- Basic nvim-tree setup
require("nvim-tree").setup()

-- Treesitter configuration for better syntax highlighting
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- Enable highlighting
    additional_vim_regex_highlighting = false,
  },
}

-- Completion setup using nvim-cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})

-- Dashboard setup
local db = require('dashboard')
db.setup({
    theme = 'doom',
    config = {
        week_header = {
            enable = true,
        },
        -- Center section with icons, descriptions, and actions
        center = {
            {
                icon = '  ',
                icon_hl = 'DashboardIcon',
                desc = 'New file',
                desc_hl = 'DashboardDesc',
                key = 'n',
                key_hl = 'DashboardKey',
                key_format = ' [%s]',  -- Display format for key
                action = 'enew',  -- Open a new file
            },
            {
                icon = '  ',
                icon_hl = 'DashboardIcon',
                desc = 'Find file',
                desc_hl = 'DashboardDesc',
                key = 'f',
                key_hl = 'DashboardKey',
                key_format = ' [%s]',
                action = 'Telescope find_files',  -- Open Telescope to find files
            },
            {
                icon = '  ',
                icon_hl = 'DashboardIcon',
                desc = 'File explorer',
                desc_hl = 'DashboardDesc',
                key = 'e',
                key_hl = 'DashboardKey',
                key_format = ' [%s]',
                action = 'NvimTreeToggle',  -- Toggle file explorer
            },
            {
                icon = '  ',
                icon_hl = 'DashboardIcon',
                desc = 'Edit dotfiles',
                desc_hl = 'DashboardDesc',
                key = 'd',
                key_hl = 'DashboardKey',
                key_format = ' [%s]',
                action = 'Telescope dotfiles',  -- Open Telescope to find dotfiles
            },
            {
                icon = '󰊳  ',
                icon_hl = 'DashboardIcon',
                desc = 'Update plugins',
                desc_hl = 'DashboardDesc',
                key = 'u',
                key_hl = 'DashboardKey',
                key_format = ' [%s]',
                action = 'Lazy update',  -- Update Lazy.nvim plugins
            },
        },
        -- Footer with a simple message or version info
        footer = {
            '',
' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
	    '',
	    '',
            'https://neovim.io',
        },
    },
})

vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#AB7BA3' })
vim.api.nvim_set_hl(0, 'DashboardDesc', { fg = '#8dbaab' })
vim.api.nvim_set_hl(0, 'DashboardKey', { fg = '#51afef' })
vim.cmd [[
    highlight DashboardFooter guifg=#8dcbcc
    highlight DashboardHeader guifg=#8dcbcc
]]

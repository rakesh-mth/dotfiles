-- Basic settings
vim.o.number = true               -- Show line numbers
vim.o.relativenumber = true       -- Show relative line numbers
vim.o.tabstop = 4                 -- Number of spaces that a <Tab> in the file counts for
vim.o.shiftwidth = 4              -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true            -- Use spaces instead of tabs
vim.o.mouse = 'a'                 -- Enable mouse support
-- vim.o.path+=**
vim.o.wildmenu = true
vim.o.nocompatible = true
-- vim.o.clipboard = 'unnamedplus'   -- Use system clipboard

vim.g.mapleader = " "

-- bootstrap plugin manager: packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Plugin manager setup (packer.nvim example)

require'packer'.startup(function()
    use { "ibhagwan/fzf-lua", requires = { "nvim-tree/nvim-web-devicons" } }
    use { "ellisonleao/gruvbox.nvim" }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.8', requires = { {'nvim-lua/plenary.nvim'} } }
    use { 'nvim-treesitter/nvim-treesitter', tag = '0.9.2', run = ':TSUpdate' }
    use { "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
end)

-- Plugin config

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "cmake" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    additional_vim_regex_highlighting = false,
  },
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd", "cmake" },
}
require("lspconfig").lua_ls.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").cmake.setup {}

require('fzf-lua').setup({
  -- fzf_bin = 'fzf-winpty',
  -- fzf_bin = 'fzfw',
})

-- Function to loop through the quickfix list
function LoopThroughQuickfix()
  local success, result = pcall(vim.cmd, 'cnext')
  if not success then
    vim.cmd('cfirst')
  end
end

-- color scheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Key mappings

-- telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Map the function to a key (e.g., F4)
vim.api.nvim_set_keymap('n', '<F4>', ':lua LoopThroughQuickfix()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-o>', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })

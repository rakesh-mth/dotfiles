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

-- bootstrap packer
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
    use { "ibhagwan/fzf-lua",
        -- optional for icon support
        requires = { "nvim-tree/nvim-web-devicons" }
        -- or if using mini.icons/mini.nvim
        -- requires = { "echasnovski/mini.icons" }
    }

    use { 'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end)

require('fzf-lua').setup({
  -- fzf_bin = 'fzf-winpty',
  -- fzf_bin = 'fzfw',
})

-- telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Key mappings
-- vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })

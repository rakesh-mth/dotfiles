-- Basic settings
vim.o.number = true               -- Show line numbers
vim.o.relativenumber = true       -- Show relative line numbers
vim.o.tabstop = 4                 -- Number of spaces that a <Tab> in the file counts for
vim.o.shiftwidth = 4              -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true            -- Use spaces instead of tabs
vim.o.mouse = 'a'                 -- Enable mouse support
-- vim.o.path+=**
vim.o.wildmenu = true
-- vim.o.nocompatible = true
-- vim.o.clipboard = 'unnamedplus'   -- Use system clipboard

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootstrap plugin manager: lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin manager setup (lazy.nvim example)

-- Setup lazy.nvim
require("lazy").setup({
  spec = { { import = "plugins" }, },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

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

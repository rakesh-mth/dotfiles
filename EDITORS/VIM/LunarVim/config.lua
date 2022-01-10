--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- *
-- [rakesh] Settings by me [begin]
-- *
local init_custom_options = function()
  local custom_options = {
    relativenumber = true, -- Set relative numbered lines
    colorcolumn = "120", -- Indent line at what column? Set something like '99999' to not display it
    scrolloff = 5, -- Determines the number of context lines you would like to see above and below the cursor
    ignorecase = true, -- Ignore case in search
    smartcase = true, -- Case-sensitive search when search term contains uppercase characters. Otherwise, case-sensitive search.
    timeoutlen = 200, -- Time to wait for a mapped sequence to complete (in milliseconds)
  }

  for k, v in pairs(custom_options) do
    vim.opt[k] = v
  end
end
init_custom_options()
-- update PATH - both are same (vim.cmd and vim.env version)
if vim.loop.os_uname().version:match "Windows" then
  -- vim.cmd [[let $PATH='C:\Program Files\Git\bin;'.$PATH]]
  vim.env.PATH = table.concat({ "C:\\Program Files\\Git\\bin;", vim.env.PATH }, ";")
end

-- *
-- [rakesh] Settings by me [END]
-- *

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.transparent_window = false
-- [rakesh] - colorscheme kanagawa was installed
lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "kanagawa"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- [rakesh] uncommented - 15 lines
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- [rakesh] uncommented - 10 lines
lvim.builtin.which_key.mappings["t"] = {
  name = "+Telescope",
  r = { "<cmd>Telescope lsp_references<cr>", "References" },
  f = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Diagnostics" },
  b = { "<cmd>Telescope builtin<cr>", "Builtin" },
  g = { "<cmd>Telescope live_grep<cr>", "LiveGrep" },
  q = { "<cmd>Telescope quickfix<cr>", "QuickFix" },
  l = { "<cmd>Telescope loclist<cr>", "LocationList" },
  w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Diagnostics" },
  o = { "<cmd>Telescope oldfiles<cr>", "Recently Used Files" },
}
-- [rakesh] lsp and null-ls mappings
lvim.builtin.which_key.mappings["l"]["n"] = { "<cmd>NullLsInfo<CR>", "null-ls info" }
-- [rakesh] - additional which key
lvim.builtin.which_key.mappings["p"]["p"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["p"]["f"] = { "<cmd>Telescope find_files<CR>", "Files" }
lvim.builtin.which_key.mappings["p"]["F"] = {
  "<cmd>lua require\"telescope.builtin\".find_files({ find_command = {'fd', '--type', 'f', '--no-ignore-vcs', '--hidden', '--follow', '-E', '.git' } })<CR>",
  "Files (All)",
}
lvim.builtin.which_key.mappings["b"]["b"] = { "<cmd>Telescope buffers<CR>", "Buffers" }
lvim.builtin.which_key.mappings["b"]["c"] = { "<cmd>BufferClose<CR>", "Buffer Close" }
lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>BufferDelete<CR>", "Buffer Delete" }
lvim.builtin.which_key.mappings["b"]["p"] = { "<cmd>b#<CR>", "Previous" }
-- lvim.builtin.which_key.mappings["'"]      = { "<cmd>ToggleTerm<CR>", "Open Terminal" }
-- lvim.builtin.which_key.mappings["g"]["g"] = { "<cmd>Git|wincmd _|normal gu<CR>", "Git Status" }
lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>Telescope grep_string<cr>", "Grep String" }
lvim.builtin.which_key.mappings["*"] = { "<cmd>Telescope grep_string<cr>", "Grep String" }
lvim.builtin.which_key.mappings["n"] = {
  name = "Extras",
  h = { "<cmd>noh<CR>", "no highlight" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
-- [rakesh] - enable dap
lvim.builtin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "cmake",
  "c",
  "cpp",
  "javascript",
  "json",
  "lua",
  "commonlisp",
  "python",
  "ruby",
  "typescript",
  "css",
  "rust",
  "go",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- [rakesh] terminal settings
-- lvim.builtin.terminal.open_mapping = [[<leader>']]
lvim.builtin.which_key.mappings["a"] = {
  name = "+Applications",
}
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "htop", "<leader>ah", "htop" }
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "btm", "<leader>ab", "bottom" }
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "ipython3", "<leader>ap", "IPython3" }

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { exe = "black", filetypes = { "python" } },
--   { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- [rakesh] add formatters with null-ls
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black", filetypes = { "python" } },
  { exe = "stylua", filetypes = { "lua" } },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- [rakesh] add linters with null-ls
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { exe = "flake8", filetypes = { "python" } },
  { exe = "luacheck", filetypes = { "lua" } },
  { exe = "shellcheck" },
}

-- Additional Plugins
-- [rakesh] uncommented, added few plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- use lazygit instead of vim-fugitive
  -- {"tpope/vim-fugitive"},
  { "godlygeek/tabular" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },

  -- color schema
  { "rebelot/kanagawa.nvim" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },

  -- delete git commit buffer after :wq, git waits for nvr to finish
  { "FileType", "gitcommit,gitrebase", "set bufhidden=delete" },
  -- map <tab> to = to match it with magit in emacs.
  { "FileType", "fugitive", "nmap <buffer> <tab> =" },
  -- map q to gq for quit to match with magit in emacs. Note: q for
  -- recording macro will not work if it is mapped to gq
  { "FileType", "fugitive", "nmap <buffer> q gq" },
}

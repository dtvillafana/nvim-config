local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Other Keymappings
-- some lsp keymaps can be found in the handlers.lua in the lsp folder
-- $HOME/Sync/dotfiles/config/nvim/lua/plugins/lsp/handlers.lua


-- Normal Mode --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- exiting controls
keymap("n", "<leader>q", "<CMD>q<CR>", opts)
keymap("n", "<leader>w", "<CMD>w!<CR>", opts)
keymap("n", "<leader>x", "<CMD>x<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<CMD>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<CMD>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<CMD>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<CMD>vertical resize +2<CR>", opts)

-- Navigate/Control buffers
keymap("n", "<S-l>", "<CMD>bnext<CR>", opts)
keymap("n", "<S-h>", "<CMD>bprevious<CR>", opts)
keymap("n", "<leader>bd",  "<CMD>bdelete<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- remove highlighting
keymap("n", "<leader>nh", "<CMD>nohl<CR>", opts)

-- Terminals -- main prefix is 't' for "terminal"
keymap("n", "<leader>tt", "<CMD>lua _TERM_TOGGLE_TAB()<CR>", {noremap = false, silent = true})
keymap("n", "<leader>tf", "<CMD>lua _TERM_TOGGLE_FLOAT(vim.v.count)<CR>", {noremap = false, silent = true})
keymap("n", "<leader>tv", "<CMD>lua _TERM_TOGGLE_VERT()<CR>", {noremap = false, silent = true})
keymap("n", "<leader>th", "<CMD>lua _TERM_TOGGLE_HORIZ()<CR>", {noremap = false, silent = true})
keymap("n", "<leader>tl", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", {noremap = false, silent = true})
keymap("n", "<leader>tb", "<CMD>lua _BPYTOP_TOGGLE()<CR>", {noremap = false, silent = true})

-- Telescope -- main prefix is 'f' for "find"
keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fr", "<CMD>Telescope frecency<CR>", opts)
keymap("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fs", "<CMD>Telescope persisted<CR>", opts)
keymap("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "<leader>fd", "<CMD>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>e", "<CMD>Telescope file_browser<CR>", opts)
keymap("n", "<leader>fo", "<CMD>Telescope orgmode search_headings<CR>", opts)

-- Orgmode -- main prefix is 'o' for "orgmode"
keymap("n", "<leader>or", "<CMD>Telescope orgmode refile_heading<CR>", opts)

-- my own gui stuff
keymap("n", "<S-Up>", "<CMD>lua ModifyFontSize(1)<CR>", opts)
keymap("n", "<S-Down>", "<CMD>lua ModifyFontSize(-1)<CR>", opts)

-- Insert Mode --
-- Press jk fast to return to normal mode
keymap("i", "jk", "<ESC>", opts)

-- Visual Mode --
-- yank to system clipboard
keymap("v", "<leader>y", "\"+y", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", "<CMD>m .+1<CR>==", opts)
keymap("v", "<A-k>", "<CMD>m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", "<CMD>move '>+1<CR>gv-gv", opts)
keymap("x", "K", "<CMD>move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", "<CMD>move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", "<CMD>move '<-2<CR>gv-gv", opts)

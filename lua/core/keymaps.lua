local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

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
-- $HOME/git-repos/dotfiles/config/nvim/lua/plugins/lsp/handlers.lua

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
keymap("n", "<leader>bd", "<CMD>Bdelete<CR>", opts)

-- Navigate/Control tabs
keymap("n", "<S-Left>", "<CMD>tabnext<CR>", opts)
keymap("n", "<S-Right>", "<CMD>tabprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- remove highlighting
keymap("n", "<leader>nh", "<CMD>nohl<CR>", opts)

-- Terminals -- main prefix is 't' for "terminal"
keymap("n", "<leader>tt", "<CMD>lua _TERM_TOGGLE_TAB(vim.v.count)<CR>", { noremap = false, silent = true })
keymap("n", "<leader>tf", "<CMD>lua _TERM_TOGGLE_FLOAT(vim.v.count)<CR>", { noremap = false, silent = true })
keymap("n", "<leader>tv", "<CMD>lua _TERM_TOGGLE_VERT(vim.v.count)<CR>", { noremap = false, silent = true })
keymap("n", "<leader>th", "<CMD>lua _TERM_TOGGLE_HORIZ(vim.v.count)<CR>", { noremap = false, silent = true })
keymap("n", "<leader>tl", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", { noremap = false, silent = true })
keymap("n", "<leader>tb", "<CMD>lua _BPYTOP_TOGGLE()<CR>", { noremap = false, silent = true })
keymap("n", "<leader>tj", "<CMD>lua _NODE_TOGGLE()<CR>", { noremap = false, silent = true })
keymap("n", "<leader>tn", "<CMD>lua _NCDU_TOGGLE()<CR>", { noremap = false, silent = true })
if READ_SHELL_COMMAND("uname -r"):match(".*WSL2") then
    keymap("n", "<leader>tp", "<CMD>lua _POWERSHELL_TOGGLE()<CR>", { noremap = false, silent = true })
end

-- Telescope -- main prefix is 'f' for "find"
keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fr", "<CMD>Telescope frecency<CR>", opts)
keymap("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fs", "<CMD>Telescope persisted<CR>", opts)
keymap("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "<leader>fd", "<CMD>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fo", "<CMD>Telescope orgmode search_headings<CR>", opts)
keymap("n", "<leader>fq", "<CMD>Telescope quickfix<CR>", opts)
keymap("n", "<leader>fn", "<CMD>Telescope notify<CR>", opts)
keymap("n", "<leader>fm", "<CMD>Telescope toggleterm_manager<CR>", opts)
keymap("n", "<leader>fk", "<CMD>Telescope keymaps<CR>", opts)
keymap("n", "<leader>ft", "<CMD>TodoTelescope<CR>", opts)
keymap("n", "<leader>e", "<CMD>Oil --float<CR>", opts)

-- Orgmode -- main prefix is 'o' for "orgmode"
-- /home/dvillafana/git-repos/dotfiles/nvim/lua/core/options.lua +119

-- View project hierarchy using nvim-tree
keymap("n", "<leader>v", "<CMD>NvimTreeToggle<CR>", opts)

-- create a new tab for scoped buffer session
keymap("n", "<leader><C-t>", "<CMD>tabnew<CR>", opts)

-- my own lua commands -- main prefix is 'r' for "run"
keymap("n", "<leader>r<Up>", "<CMD>lua ModifyFontSize(vim.v.count, 1)<CR>", opts)
keymap("n", "<leader>r<Down>", "<CMD>lua ModifyFontSize(vim.v.count, -1)<CR>", opts)
keymap("n", "<leader>rc", "<CMD>lua SET_CWD_TO_BUF_DIR()<CR>", opts)
keymap("n", "<leader>nd", '<CMD>lua require("notify").dismiss()<CR>', opts)
keymap("n", "<leader>sq", "<CMD>DBUIToggle<CR>", opts)
keymap("n", "<leader>gb", "<CMD>lua GIT_BLAME_CURRENT_LINE()<CR>", opts)

-- Insert Mode --
-- Press jk or kj fast to return to normal mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual Mode --
-- yank to system clipboard
keymap("v", "<leader>y", '"+y', opts)

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
-- other keymap links, use gF to goto
-- ../plugins/resession.lua:54
-- ../plugins/toggleterm.lua:40
-- ../plugins/flash.lua:181
-- ../plugins/treesitter.lua:56
-- ../core/options.lua:118
-- ../plugins/oil.lua:60
-- ../plugins/lsp/handlers.lua:63
-- ../plugins/dap.lua:27

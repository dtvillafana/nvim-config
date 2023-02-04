function split(str, sep)
   local result = {}
   for word in str:gmatch("[^"..sep.."]+") do
    table.insert(result, word)
   end
   return result
end

function IncreaseFont()
    local currentFontString = vim.opt.guifont["_value"]
    local fontName = split(currentFontString, ":")[1]
    local fontSize = split(currentFontString, ":")[2]
    local fontNum = split(fontSize, "h")[1]
    vim.opt.guifont=fontName..":h"..(fontNum+1)
end

function DecreaseFont()
    local currentFontString = vim.opt.guifont["_value"]
    local fontName = split(currentFontString, ":")[1]
    local fontSize = split(currentFontString, ":")[2]
    local fontNum = split(fontSize, "h")[1]
    vim.opt.guifont = fontName..":h"..(fontNum-1)
end

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
-- lsp keymaps can be found in the handlers.lua in the lsp folder
-- $HOME/Sync/dotfiles/config/nvim/lua/user/lsp/handlers.lua
-- toggleterm/terminal keymaps can be found in the toggleterm.lua file
-- $HOME/Sync/dotfiles/config/nvim/lua/user/toggleterm.lua


-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Telescope commands
keymap("n", "<leader>e", ":Telescope file_browser<CR>", opts)
keymap("n", "<leader>os", ":Telescope orgmode search_headings<CR>", opts)

-- Buffer controls

-- exiting controls
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w!<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate/Control buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd",  ":Bdelete<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- remove highlighting
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- yank to system clipboard
keymap("v", "<leader>y", "\"+y", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
keymap("n", "<leader>t", "<C-t><C-o>", {noremap = false, silent = true}) -- this is remapped this way because toggleterm defaults 
-- its open mapping to be available in all modes
-- other terminal naviation and whatnot is handled in toggleterm config

-- Telescope
keymap("n", "<leader><S-f>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>f", "<cmd>Telescope live_grep<cr>", opts)

-- my own gui stuff
keymap("n", "<S-Up>", ":lua IncreaseFont()<CR>", opts)
keymap("n", "<S-Down>", ":lua DecreaseFont()<CR>", opts)

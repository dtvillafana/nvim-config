local options = {
    backup = false,                          -- creates a backup file
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    cmdheight = 2,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 2,                        -- was originally set to 0 so that `` is visible in markdown files, is now set to 2 so emphasis markers in org are hidden
    concealcursor = "nc",
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                         -- always show tabs
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    swapfile = false,                        -- creates a swapfile
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                         -- enable persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- number of spaces that make up a tab
    cursorline = true,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = true,                  -- set relative numbered lines
    numberwidth = 4,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    wrap = true,                             -- wrap lines that are too long to display on the screen
    scrolloff = 4,                           -- is one of my fav
    sidescrolloff = 4,
    showbreak = "﬌ ",
    -- highlight = "OrgFolded ctermfg=WHITE"
    guifont = "SauceCodePro Nerd Font Mono"..":h11",               -- the font used in graphical neovim applications
}

local guiopts = {
    -- neovide_transparency = 0.8,
    neovide_cursor_vfx_mode = 'railgun',
    neovide_cursor_vfx_particle_density = 20.0,
    neovide_cursor_vfx_particle_speed = 10.0,
    neovide_cursor_vfx_particle_lifetime = 1,
    neovide_cursor_vfx_opacity = 1000.0,
    -- only for railgun vfx mode
    neovide_cursor_vfx_particle_phase = 0.5, -- Sets the mass movement of particles, or how individual each one acts. The higher the value, the less particles rotate in accordance to each other, the lower, the more line-wise all particles become.
    neovide_cursor_vfx_particle_curl = 0.0, -- Sets the velocity rotation speed of particles. The higher, the less particles actually move and look more "nervous", the lower, the more it looks like a collapsing sine wave.
}

local cmds = {
    colorscheme = "onedark",
}

function Set_Filetype()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename:match(".curl$") or filename:match(".wget$") then
        vim.api.nvim_command("set filetype=bash")
    end
end

local autocommands = {
    set_custom_extensions_to_bash = "autocmd BufRead,BufNewFile * lua Set_Filetype()",
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'org',
  group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
  callback = function()
    vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
  end,
})

vim.opt.shortmess:append "c"

for k, v in pairs(guiopts) do
    vim.g[k] = v
end

for k, v in pairs(options) do
    vim.opt[k] = v
end

for k, v in pairs(cmds) do
    vim.cmd[k](v)
end

for _, value in pairs(autocommands) do
    vim.api.nvim_command(value)
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

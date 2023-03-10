local options = {
    mouse = nil,
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
    showbreak = "??? ",
    guifont = "SauceCodePro Nerd Font Mono"..":h12",               -- the font used in graphical neovim applications
    sessionoptions = "buffers,curdir,folds,winpos,winsize",
    -- Table Mode
}

local globalopts = {
    -- neovide_transparency = 0.8,
    neovide_cursor_vfx_mode = 'railgun',
    neovide_cursor_vfx_particle_density = 20.0,
    neovide_cursor_vfx_particle_speed = 10.0,
    neovide_cursor_vfx_particle_lifetime = 1, -- this is measured in seconds
    neovide_cursor_vfx_opacity = 1000.0,
    -- only for railgun vfx mode
    neovide_cursor_vfx_particle_phase = 0.5, -- Sets the mass movement of particles, or how individual each one acts. The higher the value, the less particles rotate in accordance to each other, the lower, the more line-wise all particles become.
    neovide_cursor_vfx_particle_curl = 0.0, -- Sets the velocity rotation speed of particles. The higher, the less particles actually move and look more "nervous", the lower, the more it looks like a collapsing sine wave.
    table_mode_disable_mappings = 'true',
    table_mode_map_prefix = '<leader>m',
    table_mode_tablesize_map = '<leader>mt',
    table_mode_toggle_map = 'm',
}

function ModifyFontSize(num)
    vim.notify.dismiss() -- TODO: change this from dismissing notifications to updating the notification with the same title
    local currentFontString = vim.opt.guifont["_value"]
    local fontParsed = vim.split(currentFontString, ":h")
    local fontName = fontParsed[1]
    local fontSize = fontParsed[2]
    vim.opt.guifont=fontName..":h"..(fontSize+num)
    vim.notify(vim.opt.guifont["_value"], vim.log.levels.INFO, {title = "Font Changed"} )
end

function Set_Filetype()
    local f = vim.api.nvim_buf_get_name(0)
    if f:match(".curl$")
        or f:match(".wget$") then
        vim.api.nvim_command("set filetype=bash")
    elseif f:match(".aspx$")
        or f:match(".ascx$")
        or f:match("[wW]web.[cC]onfig$") then
        vim.api.nvim_command("set filetype=xml")
    end
end

function SET_CWD_TO_BUF_DIR()
    local current_buf = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(current_buf)
    local directory = vim.fn.fnamemodify(filepath, ":h")
    local command = "cd " .. directory
    vim.api.nvim_exec(command, false)
end

local cmds = {
    colorscheme = "onedark",
}

local autocommands = {
    set_custom_extensions_to_bash = "autocmd BufRead,BufNewFile * lua Set_Filetype()",
    set_telescope_preview_wrap = "autocmd User TelescopePreviewerLoaded setlocal wrap",
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'org',
    group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
    callback = function()
        vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
    end,
})

-- suppresses insert completion popup menu 
vim.opt.shortmess:append "c"

for k, v in pairs(globalopts) do
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

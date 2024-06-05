local options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    concealcursor = "nc",
    conceallevel = 2, -- was originally set to 0 so that `` is visible in markdown files, is now set to 2 so emphasis markers in org are hidden
    cursorline = true, -- highlight the current line
    expandtab = true, -- convert tabs to spaces
    fileencoding = "utf-8", -- the encoding written to a file
    foldcolumn = "0", -- '0' is not bad                                                     
    foldenable = true,
    foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
    foldlevelstart = 99,
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    linebreak = true, -- break wrapped lines at sensible characters
    mouse = "", -- enable or disable mouse
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    pumheight = 10, -- pop up menu height
    relativenumber = true, -- set relative numbered lines
    scrolloff = 4, -- set how many lines the cursor can be from the edge of the screen before scrolling
    sessionoptions = "buffers,curdir,folds,winpos,winsize,tabpages,globals",
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    sidescrolloff = 4,
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 4, -- number of spaces that make up a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    wrap = true, -- wrap lines that are too long to display on the screen
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

local globalopts = {
    -- neovide_transparency = 0.8,
    neovide_cursor_vfx_mode = "railgun",
    neovide_cursor_vfx_particle_density = 20.0,
    neovide_cursor_vfx_particle_speed = 10.0,
    neovide_cursor_vfx_particle_lifetime = 1, -- this is measured in seconds
    neovide_cursor_vfx_opacity = 1000.0,
    -- only for railgun vfx mode
    neovide_cursor_vfx_particle_phase = 0.5, -- Sets the mass movement of particles, or how individual each one acts. The higher the value, the less particles rotate in accordance to each other, the lower, the more line-wise all particles become.
    neovide_cursor_vfx_particle_curl = 0.0, -- Sets the velocity rotation speed of particles. The higher, the less particles actually move and look more "nervous", the lower, the more it looks like a collapsing sine wave.
    table_mode_disable_mappings = "true",
    table_mode_map_prefix = "<leader>m",
    table_mode_tablesize_map = "<leader>mt",
    table_mode_toggle_map = "m",
    neovide_scroll_animation_length = 0.1
}
local match_ansible = function(path, bufnr, matches)
    local p = path
    if p:match(".*ansible.*yml") or p:match(".*ansible.*inventory") or p:match(".*ansible.*yaml") then
        return "yaml.ansible"
    else
        return "yaml"
    end
end

-- add or override non-builting filetypes
vim.filetype.add({
    extension = {
        pnd = "poweron",
        PND = "poweron",
        po = "poweron",
        PO = "poweron",
        pro = "poweron",
        PRO = "poweron",
        def = "poweron",
        DEF = "poweron",
        sub = "poweron",
        SUB = "poweron",
        set = "poweron",
        SET = "poweron",
        fmp = "poweron",
        FMP = "poweron",
        fm = "poweron",
        FM = "poweron",
        inc = "poweron",
        INC = "poweron",
        symform = "poweron",
        SYMFORM = "poweron",
        curl = "bash",
        wget = "bash",
        aspx = "xml",
        ascx = "xml",
        asmx = "xml",
    },
    pattern = {
        [".*.%d%d%d"] = "poweron",
        ["EAR.*"] = "poweron",
        ["ear.*"] = "poweron",
        ["EMA.*"] = "poweron",
        ["ema.*"] = "poweron",
        ["ELA.*"] = "poweron",
        ["ela.*"] = "poweron",
        ["/home/dvillafana/programs/poweron/specfiles/*.*"] = "poweron",
        [".*inventory"] = match_ansible,
        [".*yml"] = match_ansible,
        [".*yaml"] = match_ansible,
    },
})

local autocommands = {
    set_orgmode_telescope_refiling = {
        { "FileType" },
        {
            pattern = ".*org",
            group = vim.api.nvim_create_augroup("orgmode_telescope_nvim", { clear = true }),
            callback = function()
                vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading)
            end,
        },
    },
}

-- suppresses insert completion popup menu
vim.opt.shortmess:append("c")

if vim.g.neovide then
    for k, v in pairs(globalopts) do
        vim.g[k] = v
    end
end

for k, v in pairs(options) do
    vim.opt[k] = v
end

for _, value in pairs(autocommands) do
    local event = value[1]
    local opts = value[2]
    vim.api.nvim_create_autocmd(event, opts)
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

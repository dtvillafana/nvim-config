local path = function()
    local function directory_exists(path)
        local stat = vim.loop.fs_stat(path)
        return stat and stat.type == "directory"
    end

    local directory_path = os.getenv("HOME") .. "/.local/share/gopass/"
    if directory_exists(directory_path) then
        return directory_path
    else
        local altpath = os.getenv("HOME") .. "/git-repos/pass/"
        if directory_exists(altpath) then
            return altpath
        end
    end
end
return {
    "dtvillafana/omen.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    opts = {
        picker = "telescope", -- Picker type
        title = "Omen", -- Title to be displayed on the picker
        store = path(),
        passphrase_prompt = "Passphrase: ", -- Prompt when asking the passphrase
        register = "+", -- Which register to fill after decoding a password
        retention = 45, -- Delay before password is cleared from the register
        ignored = { -- Ignored directories or files that are not to be listed in picker
            ".git",
            ".gitattributes",
            ".gpg-id",
            ".stversions",
            "Recycle Bin",
        },
        use_default_keymaps = true, -- Whether display info messages or not
    },
}

function ModifyFontSize(num, multiplier)
    require("notify").dismiss() -- TODO: change this from dismissing notifications to updating the notification with the same title
    local currentFontString = vim.opt.guifont["_value"]
    local fontParsed = vim.split(currentFontString, ":h")
    local fontName = fontParsed[1]
    local fontSize = fontParsed[2]
    if num == 0 then
        num = 1
    end
    vim.opt.guifont = fontName .. ":h" .. (fontSize + (num * multiplier))
    require("notify").notify(vim.opt.guifont["_value"], vim.log.levels.INFO, { title = "Font Changed" })
end

function SET_CWD_TO_BUF_DIR()
    local current_buf = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(current_buf)
    local directory = vim.fn.fnamemodify(filepath, ":h")
    local command = "cd " .. directory
    vim.api.nvim_exec2(command, { output = false })
end

function READ_SHELL_COMMAND(cmd)
    local handle = io.popen(cmd)
    local result = ""
    if handle ~= nil then
        result = handle:read("*a")
        handle:close()
    end
    return result
end

function GIT_BLAME_CURRENT_LINE()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
        print("Error, failed to load gitsigns!")
        return
    end
    gitsigns.blame_line()
end

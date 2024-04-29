return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local status_ok, alpha = pcall(require, "alpha")
        if not status_ok then
            print("alpha-nvim failed to load!")
            return
        end

        -- might have to get rid of the local dashboard =
        local dashboard = require("alpha.themes.dashboard")
        require("alpha.term")

        local function button(sc, txt, keybind, keybind_opts)
            local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

            local opts = {
                position = "center",
                shortcut = sc,
                cursor = 5,
                width = 30,
                align_shortcut = "right",
                hl_shortcut = "Keyword",
            }

            if keybind then
                keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
                opts.keymap = { "n", sc_, keybind, keybind_opts }
            end

            local function on_press()
                local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
                vim.api.nvim_feedkeys(key, "normal", false)
            end

            return {
                type = "button",
                val = txt,
                on_press = on_press,
                opts = opts,
            }
        end

        -- Obtain Date Info
        local date_info = "󰨲 Today is " .. os.date()

        -- Config gif header

        local dynamic_header = {
            type = "terminal",
            command = "chafa -c full --fg-only --symbols braille ~/Sync/assets/gif/crusader.gif",
            width = 100,
            height = 45,
            opts = {
                position = "center",
                redraw = true,
                window_config = {},
            },
        }

        local date_today = {
            type = "text",
            val = date_info,
            opts = {
                position = "left",
                redraw = true,
            },
        }

        local buttons = {
            type = "group",
            val = {
                button("l", " -> Load last session", ':lua require("resession").load("last")<CR>'),
                button("f", " -> Find file", ":Telescope find_files<CR>"),
                button("c", " -> Set Color Scheme", ":colorscheme catppuccin-latte<CR>"),
                -- button("e", " -> New file", ":ene <BAR> startinsert <CR>"),
                -- button("e", " -> New file", ":RnvimrToggle <CR>"),
                -- button("p", " -> Find project", ":Telescope projects <CR>"),
                button(
                    "r",
                    " -> Recently used files",
                    "<cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>"
                ),
                button("t", " -> Find text", ":Telescope live_grep <CR>"),
                -- button("c", " -> Configuration", ":e ~/.config/nvim/init.lua <CR>"),
                button("z", " -> Quit Neovim", ":qa<CR>"),
            },
            opts = {
                spacing = 0,
                position = "center",
                redraw = true,
            },
        }

        local section = {
            header = dynamic_header,
            date = date_today,
            buttons = buttons,
        }

        local opts = {
            layout = {
                -- section.date,
                -- { type = "padding", val = 2 },
                section.header,
                section.buttons,
                -- { type = "padding", val = 2 },
            },
            opts = {
                margin = 0,
                noautocmd = true,
                redraw_on_resize = true,
            },
        }

        dashboard.opts = opts
        alpha.setup(dashboard.opts)
    end,
}

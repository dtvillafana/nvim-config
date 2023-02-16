return {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        local status_ok, indent_blankline = pcall(require, "indent_blankline")
        if not status_ok then
            return
        end
        indent_blankline.setup(
        {
            -- char = '|',
            char_list_blankline = {'', '', '', '', '', '', '', '', ''},
            show_trailing_blankline_indent = false,
            show_first_indent_level = false
        }
        )
    end
}

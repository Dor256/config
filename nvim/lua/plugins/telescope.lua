return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- optional but recommended
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                initial_mode = "normal",
                mappings = {
                    n = {
                        ["<C-d>"] = actions.delete_buffer,
                        ["<C-f>"] = actions.preview_scrolling_down,
                    },
                    i = {
                        ["<C-h>"] = "which_key",
                        ["<C-d>"] = actions.delete_buffer,
                        ["<C-f>"] = actions.preview_scrolling_down,
                    },
                },
            },
            pickers = {
                buffers = {
                    sort_lastused = true,
                    ignore_current_buffer = true,
                }
            }
        })
    end,
}

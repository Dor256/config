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
                mappings = {
                    n = {
                        ["<C-d>"] = actions.delete_buffer
                    },
                    i = {
                        ["<C-h>"] = "which_key",
                        ["<C-d>"] = actions.delete_buffer,
                    },
                },
            },
        })
    end,
}

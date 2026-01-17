return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            hide_root_node = false,
            filesystem = {
                persistent_filter = false,
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
                use_libuv_file_watcher = true,
                bind_to_cwd = true,
                cwd_target = {
                    sidebar = "none",
                    current = "none"
                },
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    never_show = {
                        ".DS_Store",
                    }
                },
            },
            close_if_last_window = true,
            window = {
                width = 30,
                position = "current",
                mappings = {
                    -- Disables native scroll mappings if you have them
                    ["<ScrollWheelUp>"] = "none",
                    ["<ScrollWheelDown>"] = "none",
                },
                popup = {
                    title = function(_)
                        return vim.g.cwd_name or "Neo-tree"
                    end,
                },
            },
        })
    end,
}


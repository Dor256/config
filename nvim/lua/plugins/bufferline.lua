return {
    {
        'akinsho/bufferline.nvim',
        enabled = true,
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    mode = "buffer", -- Show open files as tabs
                    separator_style = "slant", -- Looks very modern
                    always_show_bufferline = false,
                    indicator = { style = "none" },
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = function()
                                return vim.g.cwd_name
                            end,
                            text_align = "center",
                            separator = '║',
                            highlight = "Directory",
                            padding = 0,
                        }
                    },
                    custom_filter = function(buf_number)
                        if vim.bo[buf_number].filetype == "neo-tree" then return false end
                        if vim.fn.bufname(buf_number) == "" then return false end
                        -- 2. Hide Neo-tree buffers from the tab list
                        return true
                    end,
                },
                highlights = {
                    offset_separator = {
                        fg = { attribute = "fg", highlight = "WinSeparator" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                },
            })
        end
    }
}


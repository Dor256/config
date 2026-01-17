return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional but recommended
    config = function()
        require("lualine").setup({
            options = {
                theme = 'tokyonight',
                globalstatus = true,
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_x = {'lsp_status', 'filetype'},
            }
        })
    end
}


return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",

    opts = {
        ensure_installed = {
            "javascript",
            "typescript",
            "haskell",
            "scala",
            "java",
            "tsx",
            "proto",
            "python",
            "json",
            "yaml",
            "cpp",
            "html",

            -- always installed
            "lua",
            "vim",
            "vimdoc",
            "c",
            "query",
        },

        sync_install = false,
        auto_install = false,
        indent = {
            enable = true,
            disable = { "c" },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                -- Enable treesitter higlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}

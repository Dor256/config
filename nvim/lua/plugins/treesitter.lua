return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
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
        auto_install = true,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        indent = {
            enable = true,
            disable = { "python", "c" },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}


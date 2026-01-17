return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- make sure it loads before other UI plugins
    opts = {},
    config = function()
        require("tokyonight").setup({
            style = "storm",
            styles = {
                keywords = { italic = false }
            },
            on_highlights = function(hl, c)
                hl.GitSignsAdd = { fg = c.green }
                hl.GitSignsChange = { fg = c.orange }
                hl.GitSignsDelete = { fg = c.red }
                hl.Directory = { fg = c.purple }
                hl.NeoTreeDirectoryName = { fg = c.fg }
                hl.NeoTreeRootNane = { fg = c.fg }
                hl.NeoTreeCursorLine = { bg = c.bg_highlight }
                hl.NeoTreeGitUntracked = { fg = c.green }
                hl.NeoTreeGitModified = { fg = c.yellow }
                hl["@keyword.import"] = {
                    link = "@keyword"
                }
            end
        })
        vim.cmd.colorscheme("tokyonight")
    end,
}


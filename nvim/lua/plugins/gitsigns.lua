return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {}, -- This tells the plugin to use all the default settings
    config = function ()
        require("gitsigns").setup({
            signs = {
                delete = { text = "┃" }
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local function map(mode, keybind, command, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, keybind, command, opts)
                end

                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview git hunk" })
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview git hunk inline" })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset git hunk" })
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = "Reset git hunk selection" })
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })

            end
        })
    end
}


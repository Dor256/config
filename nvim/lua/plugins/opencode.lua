return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    enabled = false,
    -- dependencies = {
    --   {
    --     -- `snacks.nvim` integration is recommended, but optional
    --     ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
    --     "folke/snacks.nvim",
    --     optional = true,
    --     opts = {
    --       input = {}, -- Enhances `ask()`
    --       picker = { -- Enhances `select()`
    --         actions = {
    --           opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
    --         },
    --         win = {
    --           input = {
    --             keys = {
    --               ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
    --             },
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
    config = function()
        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Select opencode…" })
        local function focus_opencode()
            vim.schedule(function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local name = vim.api.nvim_buf_get_name(buf)

                    if vim.bo[buf].buftype == "terminal" and name:find("opencode", 1, true) then
                        vim.api.nvim_set_current_win(win)
                        vim.cmd.startinsert()
                        return
                    end
                end
            end)
        end

        vim.keymap.set({ "n", "t" }, "<C-p>", function()
            require("opencode").toggle()
            focus_opencode()
        end, { desc = "Toggle opencode" })

        vim.keymap.set("n", "<leader>q",  function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })
        vim.keymap.set("v", "<leader>q", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

        -- vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
        -- vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

        -- -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
        -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
        -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
}

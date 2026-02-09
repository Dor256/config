return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local telescope = require("telescope.builtin")

        -- LspAttach autocmd for keymaps (Neovim 0.11+ pattern)
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local opts = { buffer = bufnr }

                vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP help/documentation" }))
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP jump to definition" }))
                vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP jump to declaration" }))
                vim.keymap.set("n", "<leader>gi", telescope.lsp_implementations, vim.tbl_extend("force", opts, { desc = "LSP jump to implementation" }))
                vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "LSP jump to type definition" }))
                vim.keymap.set("n", "<leader>gr", telescope.lsp_references, vim.tbl_extend("force", opts, { desc = "LSP jump to references" }))
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP Code Action" }))

                -- ESLint-specific: auto-fix on save
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.name == "eslint" then
                    vim.api.nvim_buf_create_user_command(bufnr, "EslintFixAll", function()
                        vim.lsp.buf.execute_command({
                            command = "eslint.applyAllFixes",
                            arguments = {
                                {
                                    uri = vim.uri_from_bufnr(bufnr),
                                    version = vim.lsp.util.buf_versions[bufnr]
                                },
                            },
                        })
                    end, { desc = "Fix all eslint errors" })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end
            end
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "eslint",
            },
            automatic_installation = true,
        })

    end,
}

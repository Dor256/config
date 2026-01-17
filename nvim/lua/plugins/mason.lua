return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local telescope = require("telescope.builtin")
        -- LSP on_attach function
        -- This function is called when an LSP attaches to a buffer
        -- It sets up buffer-local keymaps that only work when LSP is active
        local function on_attach(_, bufnr)
            local opts = { buffer = bufnr }
            -- Hover documentation
            vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP help/documentation" }))
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP jump to definition" }))
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP jump to declaration" }))
            vim.keymap.set("n", "<leader>gi", telescope.lsp_implementations, vim.tbl_extend("force", opts, { desc = "LSP jump to implementation" }))
            vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "LSP jump to type definition" }))
            vim.keymap.set("n", "<leader>gr", telescope.lsp_references, vim.tbl_extend("force", opts, { desc = "LSP jump to references" }))
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP Code Action" }))
        end


        -- Show definition function
        local _open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = "rounded"
            opts.max_width = 80
            return _open_floating_preview(contents, syntax, opts, ...)
        end

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

        -- 3. The New Nvim 0.11+ Way
        -- instead of require('lspconfig').server.setup{}, we use vim.lsp.enable()

        -- A. Configure Lua Language Server specifically
        -- We modify the global config table directly before enabling
        -- Lua
        vim.lsp.config.lua_ls = {
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        }

        vim.lsp.config.eslint = {
            on_attach = function(client, bufnr)
                -- Call the shared on_attach first to set up LSP keymaps
                on_attach(client, bufnr)

                -- Then add eslint-specific configuration
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
                -- This creates an autocmd to fix files on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end
        }

        -- TypeScript/JavaScript
        vim.lsp.config.ts_ls = {
            on_attach = on_attach,
        }

        -- Python
        vim.lsp.config.pyright = {
            on_attach = on_attach,
        }

        -- Haskell
        vim.lsp.config.hls = {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.lsp.completion.enable(true, client.id, bufnr, {
                    autotrigger = true,
                })
            end,
            name = "hls",
            cmd = { "haskell-language-server-wrapper", "--lsp" },
            -- Important: Helps Neovim find the root even if you open a nested file
            root_dir = function(path)
                local root = vim.fs.root(path, { "stack.yaml", "package.yaml", ".git" })
                return root or vim.uv.cwd()
            end,
            filetypes = { "haskell", "lhaskell" },
            settings = {
                haskell = {
                    formattingProvider = "none",
                }
            },
        }

        -- Go
        vim.lsp.config.gopls = {
            on_attach = on_attach,
        }
        -- B. Enable the servers
        -- You must explicitly enable the servers you want to run.
        local servers = { "hls", "lua_ls", "ts_ls", "pyright", "eslint", "gopls" }

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end


        vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
            -- Only show messages that are Warnings (2) or Errors (1)
            -- Info is (3), Log is (4)
            if result.type <= 2 then
                return vim.lsp.handlers["window/showMessage"](_, result, ctx)
            end
            return nil
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "haskell", "lhaskell" },
            callback = function()
                local config = vim.lsp.config.hls
                if config then
                    vim.lsp.start(config)
                end
            end,
        })

    end,
}


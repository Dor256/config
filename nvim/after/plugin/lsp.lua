-- Rounded borders for hover windows
local _open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    opts.max_width = 80
    return _open_floating_preview(contents, syntax, opts, ...)
end

-- Enable servers
vim.lsp.enable({ "hls", "lua_ls", "ts_ls", "pyright", "eslint", "gopls" })

-- Filter noisy LSP messages
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
    if result.type <= 2 then
        return vim.lsp.handlers["window/showMessage"](_, result, ctx)
    end
    return nil
end


---@type vim.lsp.Config
return {
    filetypes = { "odin" },
    root_markers = { "ols.json", ".git" },
    on_attach = function(client, bufnr)
        client:notify("textDocument/didSave", {
            textDocument = { uri = vim.uri_from_bufnr(bufnr) },
        })
    end,
}

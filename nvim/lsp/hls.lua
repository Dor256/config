return {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
    root_markers = { "stack.yaml", "package.yaml", "cabal.project", "*.cabal", ".git" },
    settings = {
        haskell = {
            formattingProvider = "none",
        },
    },
}


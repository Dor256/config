return {
    init_options = {
        hostInfo = "neovim",
        preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            includeCompletionsWithSnippetText = true,
            includeAutomaticOptionalChainCompletions = true,
            includePackageJsonAutoImports = "auto",
            importModuleSpecifierPreference = "shortest",
            quotePreference = "auto",
        },
    },
    settings = {
        typescript = {
            suggest = { completeFunctionCalls = true },
            inlayHints = {
                includeInlayParameterNameHints = "literals",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            suggest = { completeFunctionCalls = true },
        },
    },
}

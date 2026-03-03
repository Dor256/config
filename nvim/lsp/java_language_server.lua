-- Workaround: Neovim 0.11.x LSP registerCapability nil table bug
-- java-language-server sends params without a registrations field
local _orig_register = vim.lsp.handlers['client/registerCapability']

-- Read classpath from .java-classpath file at project root
local function read_classpath(root_dir)
    local cp_file = root_dir .. "/.java-classpath"
    local f = io.open(cp_file, "r")
    if not f then return {} end
    local jars = {}
    for line in f:lines() do
        if line ~= "" then
            jars[#jars + 1] = line
        end
    end
    f:close()
    return jars
end

return {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/java-language-server") },
    filetypes = { "java" },
    handlers = {
        ['client/registerCapability'] = function(err, result, ctx, config)
            if result and not result.registrations then
                result.registrations = {}
            end
            return _orig_register(err, result, ctx, config)
        end,
    },
    root_markers = { "WORKSPACE", "WORKSPACE.bazel", "BUILD.bazel", "build.gradle", "pom.xml", ".git" },
    on_attach = function(client)
        local root = client.root_dir or vim.fn.getcwd()
        local classpath = read_classpath(root)
        if #classpath > 0 then
            client:notify("workspace/didChangeConfiguration", {
                settings = {
                    java = {
                        classPath = classpath,
                    },
                },
            })
        end
    end,
}

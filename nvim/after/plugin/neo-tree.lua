-- Watch .git/index for changes to refresh neo-tree git status in real-time
local git_index = vim.fn.getcwd() .. "/.git/index"
if vim.fn.filereadable(git_index) == 0 then
    return
end

local watcher = vim.uv.new_fs_event()
local on_change = vim.schedule_wrap(function()
    if package.loaded["neo-tree"] then
        pcall(function()
            require("neo-tree.sources.filesystem.commands").refresh(
                require("neo-tree.sources.manager").get_state("filesystem")
            )
        end)
    end
end)

watcher:start(git_index, {}, on_change)

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        watcher:stop()
    end,
})

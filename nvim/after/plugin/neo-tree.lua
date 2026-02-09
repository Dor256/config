-- Watch .git directory for changes to refresh neo-tree git status
local git_dir = vim.fn.getcwd() .. "/.git"
if vim.fn.isdirectory(git_dir) == 0 then
    return
end

local watcher = vim.uv.new_fs_event()
local debounce_timer = nil

local function refresh_git_status()
    if package.loaded["neo-tree.events"] then
        pcall(function()
            require("neo-tree.events").fire_event("git_event")
        end)
    end
end

local on_change = function(err, _)
    if err then
        return
    end
    -- Debounce rapid changes (git operations often write multiple files)
    if debounce_timer then
        debounce_timer:stop()
    end
    debounce_timer = vim.defer_fn(refresh_git_status, 100)
end

-- Watch the .git directory recursively
watcher:start(git_dir, { recursive = true }, on_change)

-- Also refresh git status when files are written (working directory changes)
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("neotree_git_refresh", { clear = true }),
    callback = function()
        if debounce_timer then
            debounce_timer:stop()
        end
        debounce_timer = vim.defer_fn(refresh_git_status, 100)
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if debounce_timer then
            debounce_timer:stop()
        end
        watcher:stop()
    end,
})


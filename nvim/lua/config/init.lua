vim.g.mapleader = " "
local first_arg = vim.fn.argv(0)
if first_arg ~= "" then
    local abs_path = vim.fn.fnamemodify(first_arg, ":p"):gsub("/$", "")

    if vim.fn.isdirectory(abs_path) == 1 then
        vim.cmd("cd " .. vim.fn.fnameescape(abs_path))
    end
    vim.g.cwd_name = vim.fn.fnamemodify(abs_path, ":t")
else
    vim.g.cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end
require("config.lazy")
require("config.settings")
require("config.keymaps")

vim.diagnostic.config({
    -- Ensure the most severe diagnostic is the one highlighted
    severity_sort = true,

    -- Fine-tune how they appear
    virtual_text = {
        -- Only show virtual text for the highest severity on a line
        severity = { min = vim.diagnostic.severity.WARN },
        spacing = 4,
    },
    underline = true,
})

-- How long to wait (in milliseconds) before the window pops up
-- 500ms is a good balance between "snappy" and "not annoying"
vim.opt.updatetime = 500

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
            source = 'always',
            prefix = ' ',
            header = "",
            scope = 'cursor',
            border = "rounded",
        }
        vim.diagnostic.open_float(nil, opts)
    end
})

-- Helper to check if we should reload (skip during command-line, replace, select modes)
local function should_check()
    local mode = vim.api.nvim_get_mode().mode
    return not (
        mode:match('[cR!s]')
        or vim.fn.getcmdwintype() ~= ''
    )
end

-- Autosave on leaving insert mode or changing text
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and vim.fn.bufname() ~= "" then
            vim.cmd("silent! update")
        end
    end,
})

-- Table to keep track of active watchers so we can stop them later
local active_watchers = {}

local function stop_watcher(bufnr)
    if active_watchers[bufnr] then
        active_watchers[bufnr]:stop()
        active_watchers[bufnr] = nil
    end
end

local function start_watcher(bufnr)
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    -- Don't watch if not a real file or if already being watched
    if file_path == "" or not vim.loop.fs_stat(file_path) or active_watchers[bufnr] then
        return
    end

    local watcher = vim.loop.new_fs_event()
    active_watchers[bufnr] = watcher

    -- The actual watch logic
    watcher:start(file_path, {}, vim.schedule_wrap(function(err)
        if err then
            stop_watcher(bufnr)
            return
        end

        -- Reload the buffer from disk if conditions are met
        if should_check()
            and vim.api.nvim_buf_is_valid(bufnr)
            and not vim.bo[bufnr].modified
            and vim.bo[bufnr].buftype == '' then
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("checktime")
            end)
        end

        -- Restart the watcher since fs_event can become invalid after firing
        stop_watcher(bufnr)
        vim.defer_fn(function()
            if vim.api.nvim_buf_is_valid(bufnr) then
                start_watcher(bufnr)
            end
        end, 100)
    end))
end

-- Delete empty buffers when a file is opened
local function delete_empty_buffers(current_buf)
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if bufnr ~= current_buf
            and vim.api.nvim_buf_is_valid(bufnr)
            and vim.api.nvim_buf_is_loaded(bufnr)
            and vim.api.nvim_buf_get_name(bufnr) == ""
            and vim.bo[bufnr].buftype == ""
            and not vim.bo[bufnr].modified
            and vim.api.nvim_buf_line_count(bufnr) <= 1
            and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == ""
        then
            vim.api.nvim_buf_delete(bufnr, { force = false })
        end
    end
end

-- 1. Start watching when a file is opened
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function(args)
        vim.schedule(function()
            start_watcher(args.buf)
            delete_empty_buffers(args.buf)
        end)
    end,
})

-- 2. CRITICAL: Stop watching when the buffer is closed to prevent memory leaks
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(args)
        stop_watcher(args.buf)
    end,
})


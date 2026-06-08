local telescope = require("telescope.builtin")

-- Diagnostic Keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>o", function()
    vim.cmd("Neotree toggle")
end, { desc = "Toggle focus between Neo-tree and Editor" })

-- Bufremove
vim.keymap.set("n", "<leader>w", function()
    require("mini.bufremove").delete(0, true)
    vim.schedule(function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buftype == "" then
            vim.cmd("Neotree position=current")
        end
    end)
end, { desc = "Close current buffer and move to next" })

-- Move text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down 1 line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up 1 line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Outdent selection" })

-- Replace highlited text everywhere
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace highlighted text everywhere" })

-- Format file
vim.keymap.set("n", "<leader>r", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format file according to LSP rules" })

-- Indent selection
vim.keymap.set("n", "<leader>ri", function ()
    local view = vim.fn.winsaveview()
    vim.cmd("normal! ggVG=")
    vim.fn.winrestview(view)
end, { desc = "Indent file without moving cursor" })

-- Toggle comment on the current line
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
-- Toggle comment on selected lines
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })
-- Wrap selected text in {}
vim.keymap.set("v", "<leader>{", '"zc{<C-r>z}<Esc>', { desc = "Wrap selected text in {}" })
-- Wrap selected text in ()
vim.keymap.set("v", "<leader>(", '"zc(<C-r>z)<Esc>', { desc = "Wrap selected text in ()" })
-- Wrap selected text in []
vim.keymap.set("v", "<leader>[", '"zc[<C-r>z]<Esc>', { desc = "Wrap selected text in []" })
-- Wrap selected text in <
vim.keymap.set("v", "<leader><", [["zc<<C-r>z><Esc>]], { desc = "Wrap selected text in <>" })
-- Wrap selected text in "
vim.keymap.set("v", "<leader>\"", '"zc\"<C-r>z\"<Esc>', { desc = "Wrap selected text in \"\"" })
-- Wrap selected text in '
vim.keymap.set("v", "<leader>\'", '"zc\'<C-r>z\'<Esc>', { desc = "Wrap selected text in ''" })

-- Picker search
-- Search for a file
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Search files" })
-- Search for an occurrence
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Search occurrence" })
-- Search for git conflicts
vim.keymap.set("n", "<leader>fc", telescope.git_status, { desc = "Search git conflicts" })
-- Search open buffers
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Search open buffers" })

-- Terminal
-- Allow <Esc> to enter normal mode in terminal for browsing output
vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], { desc = "Exit terminal mode to normal mode" })

-- Which key
vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Shows info for keymaps" })

-- Insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true, desc = "Outdent line" })

-- Coding agents
vim.keymap.set("n", "<leader>ll", function()
    local line_number = vim.fn.line(".")
    local file_path = vim.fn.expand("%:.")
    if file_path == "" then
        print("Error: document has no file path")
        return
    end
    local file_link = string.format("@%s:%d", file_path, line_number)

    -- Copy to system clipboard
    vim.fn.setreg("+", file_link)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    print("Copied file selection link " .. file_link)
end,
{ desc = "Copy reference to file line number at cursor" })

vim.keymap.set("v", "<leader>ll", function()
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    local start_col = vim.fn.col("v")
    local end_col = vim.fn.col(".")
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end
    local file_path = vim.fn.expand("%:.")
    if file_path == "" then
        print("Error: document has no file path")
        return
    end
    local file_link
    if start_line == end_line then
        file_link = string.format("@%s:%d:%d-%d", file_path, start_line, start_col, end_col)
    else
        file_link = string.format("@%s:%d-%d", file_path, start_line, end_line)
    end

    -- Copy to system clipboard
    vim.fn.setreg("+", file_link)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    print("Copied file selection link " .. file_link)
end,
{ desc = "Copy reference to file + line numbers in selection" })

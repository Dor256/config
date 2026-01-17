local telescope = require("telescope.builtin")

-- Diagnostic Keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>o", function()
    vim.cmd("Neotree toggle")
end, { desc = "Toggle focus between Neo-tree and Editor" })

-- Tabs Keymaps with neo-tree filtering
vim.keymap.set('n', '<Tab>', function()
    local start_buf = vim.fn.bufnr()
    vim.cmd('bnext')
    -- Keep cycling if we land on neo-tree
    local count = 0
    while vim.bo.filetype == 'neo-tree' and count < 50 do
        vim.cmd('bnext')
        count = count + 1
        -- If we've cycled back to start, break
        if vim.fn.bufnr() == start_buf then break end
    end
end, { desc = "Next buffer (skip neo-tree)" })

vim.keymap.set('n', '<S-Tab>', function()
    local start_buf = vim.fn.bufnr()
    vim.cmd('bprevious')
    -- Keep cycling if we land on neo-tree
    local count = 0
    while vim.bo.filetype == 'neo-tree' and count < 50 do
        vim.cmd('bprevious')
        count = count + 1
        -- If we've cycled back to start, break
        if vim.fn.bufnr() == start_buf then break end
    end
end, { desc = "Previous buffer (skip neo-tree)" })

-- Bufremove
vim.keymap.set("n", "<leader>w", function()
    require("mini.bufremove").delete(0, true)
end, { desc = "Close current buffer and move to next" })

-- Move text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down 1 line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up 1 line" })

-- Replace highlited text everywhere
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace highlighted text everywhere" })

-- Format file
vim.keymap.set("n", "<leader>r", function()
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
vim.keymap.set("n", "<leader>ff", function() telescope.find_files() end, { desc = "Search files" })
-- Search for an occurrence
vim.keymap.set("n", "<leader>fg", function() telescope.live_grep() end, { desc = "Search occurrence" })
-- Search for git conflicts
vim.keymap.set("n", "<leader>fc", function() telescope.git_status() end, { desc = "Search git conflicts" })

-- Terminal
-- Allow <Esc> to enter normal mode in terminal for browsing output
vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], { desc = "Exit terminal mode to normal mode" })

-- Which key
vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Shows info for keymaps" })

-- Insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true, desc = "Outdent line" })


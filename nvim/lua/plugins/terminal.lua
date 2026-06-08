return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        local default_size = 15
        local expanded_size = 40

        require("toggleterm").setup({
            -- Use <C-t> to open/close the terminal
            open_mapping = [[<c-t>]],
            direction = 'horizontal',
            size = default_size,
            -- This ensures that the terminal starts in insert mode
            start_in_insert = true,
            -- Allow the <C-t> mapping to work even when you're inside the terminal
            terminal_mappings = true,
            insert_mappings = true,
            persist_size = true,
        })

        -- Toggle terminal size between default and expanded
        local is_expanded = false
        vim.keymap.set("t", "<C-s>", function()
            if is_expanded then
                vim.cmd("resize " .. default_size)
            else
                vim.cmd("resize " .. expanded_size)
            end
            is_expanded = not is_expanded
        end, { desc = "Toggle terminal size" })
    end
}


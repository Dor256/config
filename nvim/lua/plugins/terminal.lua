return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- Use <C-j> to open/close the terminal
            open_mapping = [[<c-j>]],
            direction = 'horizontal',
            size = 15,
            -- This ensures that the terminal starts in insert mode
            start_in_insert = true,
            -- Allow the <C-j> mapping to work even when you're inside the terminal
            terminal_mappings = true,
            insert_mappings = true,
            persist_size = true,
        })
    end
}


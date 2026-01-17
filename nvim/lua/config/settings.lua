vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.list = true
vim.opt.listchars = {
    tab = "  ",
    trail = "~",
    extends = ">",
    precedes = "<",
}
vim.opt.laststatus = 3

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 8
vim.opt.showcmd = true
vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,terminal,folds"
vim.opt.autoread = true

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    command = "checktime",
})

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamed"
vim.opt.nu = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 50

vim.opt.termguicolors = true
vim.opt.fillchars = {
  vert = "║",
  horiz = "═",
  vertleft = "╣",    -- ║ meeting ═ from left
  vertright = "╠",   -- ║ meeting ═ from right
  verthoriz = "╬",   -- cross junction
  horizup = "╩",     -- ═ meeting ║ from below
  horizdown = "╦",   -- ═ meeting ║ from above
  eob = " ",
}

vim.opt.showmode = false

vim.opt.mouse = "a"

-- No automatic comment insertion
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Fonts
vim.g.have_nerd_font = true

-- Enable mouse mode.
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line.
vim.opt.showmode = false

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 2       -- 2 spaces for tabs (prettier default).
vim.opt.shiftwidth = 2    -- 2 spaces for indent width.
vim.opt.expandtab = true  -- Expand tab to spaces.
vim.opt.autoindent = true -- Copy indent from current line when starting new one.

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent.
vim.opt.breakindent = true

-- Save undo history.
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default.
vim.opt.signcolumn = 'yes'

-- Decrease update time.
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time.
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live.
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

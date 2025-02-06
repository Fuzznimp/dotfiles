-- Clear highlights on search when pressing <Esc> in normal mode.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>',
  { desc = "Clear highlights on search when pressing <Esc> in normal mode." })

-- Exit insert mode with jk
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- LSP keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "List workspace folders" })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = "Type definition" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "References" })
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, { desc = "Format" })
  end,
})

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Mini.files
vim.keymap.set("n", "<leader>t", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Open mini.files (directory of current file)" })

-- Open mini.files at current working directory
vim.keymap.set("n", "<leader>T", function()
  require("mini.files").open(vim.loop.cwd(), true)
end, { desc = "Open mini.files (cwd)" })

-- Show treesitter highlight group under cursor
vim.keymap.set("n", "<leader>hi", function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(result))
end, { desc = "Show highlight group under cursor" })

-- Lazygit
vim.keymap.set("n", "<leader>lg", function()
  local Terminal = require("snacks.terminal")
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    on_close = function()
      vim.cmd("startinsert!")
    end,
  })
  lazygit:toggle()
end, { desc = "Toggle Lazygit" })

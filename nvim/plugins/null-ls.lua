-- local present, null_ls = pcall(require, "null-ls")

-- if not present then
--   return
-- end

-- local b = null_ls.builtins

-- local sources = {
--   b.formatting.prettierd,
--   b.code_actions.eslint_d,
--   b.formatting.stylua,
--   b.formatting.rustfmt,
-- }

-- null_ls.setup {
--   debug = true,
--   sources = sources,
--   automatic_installation = true,
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup,
--             buffer = bufnr,
--             callback = function()
--                 vim.lsp.buf.format({ bufnr = bufnr })
--             end,
--         })
--     end
-- end,
-- }

local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local b = null_ls.builtins

-- Setup format on save.
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


null_ls.setup({
  debug = true,
  automatic_installation = true,
	sources = {
		b.formatting.prettierd,
		b.formatting.stylua,
    b.code_actions.eslint_d,
		b.diagnostics.eslint_d.with({
			-- Only enable eslint if root has .eslintrc.js.
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
	},
	on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
	end,
})

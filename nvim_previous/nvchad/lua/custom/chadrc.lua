local M = {}

M.ui = {
  theme = "eargasm",
  transparency = true,
  hl_add = {
    tsxTag = { fg = "red" },
  },
}

M.plugins = require "custom.plugins"

M.mappings = require "custom.mappings"

return M

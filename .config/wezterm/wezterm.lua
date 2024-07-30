local wezterm = require("wezterm")
local mux = wezterm.mux

local k = require("utils/keys")

local config = {
  background = {
    {
      source = {
        File = "~/Pictures/vrising.jpg",
      },
      width = "100%",
      repeat_x = "NoRepeat",
    }
  },
  window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  },
  window_background_opacity = 0.9,
  font = wezterm.font("Hack Nerd Font", { weight = "Bold" }),
  font_size = 14.0,
  color_scheme = "Gruvbox Material (Gogh)",
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
}

wezterm.on('gui-attached', function(domain)
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

return config

-- "Ghostty", "Alacritty", "Kitty"
local terminal = "Ghostty"
-- "Google Chrome", "Arc", "Firefox Developer Edition", "Zen"
local browser = "Arc"
-- "Cursor", "Code"
local ide = "Cursor"

hs.hotkey.bind({ "⌥" }, "space", function()
  local app = hs.application.get(terminal)
  if app then
    if not app:mainWindow() then
      app:selectMenuItem({ terminal, "New OS window" })
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus(terminal)
  end
end)

hs.hotkey.bind({ "⌃", "⌥" }, "space", function()
  local app = hs.appfinder.appFromName(ide)
  if app then
    if not app:mainWindow() then
      app:selectMenuItem({ ide, "New OS window" })
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus("Cursor")
  end
end)

hs.hotkey.bind({ "⌃", "⌥", "⌘" }, "space", function()
  local app = hs.appfinder.appFromName(browser)
  if app then
    if not app:mainWindow() then
      app:selectMenuItem({ "Arc", "New OS window" })
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus("Google Chrome")
  end
end)

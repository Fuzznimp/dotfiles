hs.hotkey.bind({ "⌥" }, "space", function()
  local app = hs.application.get("Alacritty")
  if app then
    if not app:mainWindow() then
      app:selectMenuItem({ "Alacritty", "New OS window" })
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus("Alacritty")
  end
end)

hs.hotkey.bind({ "⌃", "⌥" }, "space", function()
  local app = hs.appfinder.appFromName("Code")
  if app then
    if not app:mainWindow() then
      app:selectMenuItem({ "Code", "New OS window" })
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus("Code")
  end
end)

-- hs.hotkey.bind({ "⌃" }, "space", function()
--  local app = hs.appfinder.appFromName("Arc")
--  if app then
--      if not app:mainWindow() then
--          app:selectMenuItem({ "Arc", "New OS window" })
--      elseif app:isFrontmost() then
--          app:hide()
--      else
--          app:activate()
--      end
--  else
--      hs.application.launchOrFocus("Google Chrome")
--  end
-- end)

hs.hotkey.bind({ "⌃", "⌥", "⌘" }, "space", function()
  local app = hs.appfinder.appFromName("Arc")
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

-- hs.hotkey.bind({ "⌥", "⌘" }, "space", function()
--  local app = hs.appfinder.appFromName("Arc")
--  if app then
--      if not app:mainWindow() then
--          app:selectMenuItem({ "Arc", "New OS window" })
--      elseif app:isFrontmost() then
--          app:hide()
--      else
--          app:activate()
--      end
--  else
--      hs.application.launchOrFocus("Google Chrome")
--  end
-- end)

-- hs.hotkey.bind({ "⌃", "⌥", "⌘" }, "space", function()
--  local app = hs.appfinder.appFromName("Firefox Developer Edition")
--  if app then
--      if not app:mainWindow() then
--          app:selectMenuItem({ "Firefox Developer Edition", "New OS window" })
--      elseif app:isFrontmost() then
--          app:hide()
--      else
--          app:activate()
--      end
--  else
--      hs.application.launchOrFocus("Firefox Developer Edition")
--  end
-- end)

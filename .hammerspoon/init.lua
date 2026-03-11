-- ─── Disable system shortcuts ─────────────────────────────────────────

-- Cmd+H hides the window, Cmd+Shift+Q logs out — both too easy to hit by accident
hs.hotkey.bind({ "cmd" }, "h", function() end)
hs.hotkey.bind({ "cmd", "shift" }, "q", function() end)

-- ─── Right Command → Hyper (Cmd+Ctrl+Alt+Shift) ───────────────────────

-- Intercepts right_command (keycode 54) and replaces it with the full
-- Hyper modifier combination so external apps (Raycast, etc.) can use it.
local rightCmdDown = false

local hyperTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
  if e:getKeyCode() ~= 54 then return false end -- 54 = right_command

  local flags = e:getFlags()

  if flags.cmd and not rightCmdDown then
    rightCmdDown = true
    return true, {
      hs.eventtap.event.newKeyEvent({ "cmd", "ctrl", "alt", "shift" }, "f19", true),
    }
  elseif not flags.cmd and rightCmdDown then
    rightCmdDown = false
    return true, {
      hs.eventtap.event.newKeyEvent({ "cmd", "ctrl", "alt", "shift" }, "f19", false),
    }
  end

  return false
end)

hyperTap:start()

-- ─── Archive ───────────────────────────────────────────────────────────
-- This part has been replaced by Raycast. Keeping a trace of it just in case.

-- -- "Ghostty", "Alacritty", "Kitty"
-- local terminal = "Ghostty"
-- -- "Google Chrome", "Arc", "Firefox Developer Edition", "Zen"
-- local browser = "Zen"
-- -- "Cursor", "Code", "Zed"
-- local ide = "Zed"

-- hs.hotkey.bind({ "⌥" }, "space", function()
--   local app = hs.application.get(terminal)
--   if app then
--     if not app:mainWindow() then
--       app:selectMenuItem({ terminal, "New OS window" })
--     elseif app:isFrontmost() then
--       app:hide()
--     else
--       app:activate()
--     end
--   else
--     hs.application.launchOrFocus(terminal)
--   end
-- end)

-- hs.hotkey.bind({ "⌃", "⌥" }, "space", function()
--   local app = hs.appfinder.appFromName(ide)
--   if app then
--     if not app:mainWindow() then
--       app:selectMenuItem({ ide, "New OS window" })
--     elseif app:isFrontmost() then
--       app:hide()
--     else
--       app:activate()
--     end
--   else
--     hs.application.launchOrFocus("Cursor")
--   end
-- end)

-- hs.hotkey.bind({ "⌃", "⌥", "⌘" }, "space", function()
--   local app = hs.appfinder.appFromName(browser)
--   if app then
--     if not app:mainWindow() then
--       app:selectMenuItem({ "Arc", "New OS window" })
--     elseif app:isFrontmost() then
--       app:activate()
--     end
--   else
--     hs.application.launchOrFocus("Google Chrome")
--   end
-- end)

-- hs.hotkey.bind({ "⌃", "⌘" }, "space", function()
--   local app = hs.appfinder.appFromName(browser)
--   if app then
--     if not app:mainWindow() then
--       app:selectMenuItem({ "Slack", "New OS window" })
--     elseif app:isFrontmost() then
--       app:hide()
--     else
--       app:activate()
--     end
--   else
--     hs.application.launchOrFocus("Slack")
--   end
-- end)

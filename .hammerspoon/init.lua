hs.hotkey.bind({"⌥"}, "space", function()
    local app = hs.application.get("kitty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("kitty")
    end
end)

hs.hotkey.bind({"⌃", "⌥"}, "space", function()
    local app = hs.appfinder.appFromName("Code")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"Code", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("Code")
    end
end)
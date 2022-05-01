hs.hotkey.bind({"⌥"}, "space", function()
    local app = hs.application.get("Alacritty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"Alacritty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("Alacritty")
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

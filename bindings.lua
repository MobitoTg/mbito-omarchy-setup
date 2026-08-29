--MbitoPm Keybinding defaults
-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
--Visual Code (replaces default editor)
hl.unbind("SUPER + SHIFT + N")
o.bind("SUPER + SHIFT + N", "Editor", "code")
--Discord
o.bind("SUPER + D", "Discord", "omarchy-launch-webapp https://discord.com/channels/@me")
--Claude.ai (replaces the default Calendar binding)
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Claude", "omarchy-launch-webapp https://claude.ai")
--MbitoPM
o.bind("SUPER + M", "Mobito", "omarchy-launch-webapp https://mbitopm.com")
--Github (replaces signal keybind. I want github to be super + shift + g) 
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "GitHub", "omarchy-launch-webapp https://github.com")
-- eBay web app. Replaces the default HEY (hey.com) binding.
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "eBay", "omarchy-launch-webapp https://www.ebay.com")
-- Amazon web app. Replaces the default ChatGPT binding.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Amazon", "omarchy-launch-webapp https://www.amazon.com")
-- Apple Music web app. Replaces the default Music (Spotify) binding.
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Apple Music", "omarchy-launch-webapp https://music.apple.com")

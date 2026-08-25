# Omarchy Keybindings

How to install an app, find the command that launches it, see what is already bound, and bind it to a key.

---

## 1. Install an app

**Native package.** Use the Omarchy wrapper. It handles both the official repos and the AUR:

```bash
omarchy-pkg-add discord
```

Plain `pacman` also works for repo packages, but needs `sudo` because installing requires the root account:

```bash
sudo pacman -S github-cli
```

**Web app.** Open the Omarchy menu with `SUPER + SPACE` and choose **Install > Web App**. It asks for three things:

1. App name
2. App URL
3. Icon URL, only if it cannot pull the favicon

Dashboard Icons has good PNGs for most services.

Log into the account in regular Chromium before you use the web app. The frameless wrapper does not work well with password managers.

To remove one, use **Remove > Web App** in the same menu.

**A web app does not have to be installed before you bind it.** `omarchy-launch-webapp` takes a URL and opens a Chromium window on it. Nothing has to be registered first. Installing through the menu writes a `.desktop` file, which gets you three things: the app appears in launcher search, it shows a real icon, and it has a stable window class for Hyprland window rules. Skip the install and the hotkey still works.

Native packages are the opposite. The binary must exist on disk before a binding can call it. A binding that points at a missing binary fails silently.

---

## 2. Find the launch command

The app launcher runs `.desktop` files. The `Exec` line inside is the real command, and it is often not what you would guess.

Check whether a native binary exists:

```bash
which discord
```

Empty output means no binary. The app is a web app or a Flatpak.

Find the actual `Exec` line:

```bash
grep -i -r "^Exec" ~/.local/share/applications /usr/share/applications --include="*discord*"
```

Example result:

```
Exec=omarchy-launch-webapp https://discord.com/channels/@me
```

That whole string after `Exec=` is what goes in your binding.

**Drop any trailing `%U` or `%F`.** Those are placeholders the launcher fills in. They will break a direct exec.

List every web app on the machine:

```bash
grep -l "omarchy-launch-webapp" ~/.local/share/applications/*.desktop
```

---

## 3. See what is already bound

Print every binding with its description:

```bash
omarchy menu keybindings --print
```

Filter for one key before you claim it:

```bash
omarchy menu keybindings --print | grep -i "SUPER + D"
```

Empty result means the key is free. A result means something owns it, and you must unbind before rebinding.

A key that appears to do nothing is not always free. It can be bound to a command that fails silently, which is what happens when a binding points at a native binary that was never installed. Trust the `--print` output over the behavior.

---

## 4. Add or change a binding

Bindings live in `~/.config/hypr/bindings.lua`. This file holds only your overrides.

```bash
code ~/.config/hypr/bindings.lua
```

**Free key — bind it directly:**

```lua
o.bind("SUPER + D", "Discord", "omarchy-launch-webapp https://discord.com/channels/@me")
```

**Taken key — unbind first, then bind:**

```lua
hl.unbind("SUPER + N")
o.bind("SUPER + N", "Editor", "code")
```

Binding a key twice without unbinding leaves two handlers on one key.

Apply the change:

```bash
hyprctl reload
```

### Comment your bindings

Lua comments run from `--` to the end of the line. Write one above each block to record what the key used to do:

```lua
-- eBay web app. Replaces the default HEY (hey.com) binding.
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "eBay", "omarchy-launch-webapp https://www.ebay.com")
```

Block comments are `--[[ text ]]`, but single-line is enough here.

### Key names

Hyprland uses X11 keysyms. A few catch people out:

- `RETURN` is the main Enter key. `ENTER` is the keypad key.
- `SUPER` is Command on a MacBook and the Windows key on a ThinkPad.
- Modifier order does not matter, but stay consistent so `grep` finds your lines.

### What each part means

- `hl` — the Hyprland object. Talks directly to the compositor.
- `o` — Omarchy's helper table, layered on top of `hl`.
- `o.bind()` takes three arguments:
  - The key combination. `SUPER` is the Command key on a MacBook, the Windows key on a ThinkPad.
  - A label. This is what shows up in `omarchy menu keybindings --print`.
  - The command to run. Omarchy launches it through the session manager for you.

### Why overrides win

`~/.config/hypr/hyprland.lua` is the loader. It pulls in Omarchy's defaults first, then your override files. By the time `bindings.lua` runs, the defaults are already set, so your lines overwrite them.

Do not edit `hyprland.lua` or anything under `/usr/share/omarchy`. Package updates overwrite those.

### If a new binding does nothing

Work down these in order:

1. `hyprctl configerrors` — a Lua syntax error aborts the whole file, killing every binding in it, not just the new one
2. Did you run `hyprctl reload`?
3. `omarchy menu keybindings --print | grep -i <label>` — confirms Hyprland registered the line
4. Run the command by hand in a terminal — if it fails there, the problem is the command, not the binding

---

## 5. Reference

### Current custom bindings

Paste this whole block into `bindings.lua` on a new machine, then run `hyprctl reload`.

```lua
-- VS Code. Replaces the default SUPER + N binding.
hl.unbind("SUPER + N")
o.bind("SUPER + N", "Editor", "code")

-- GitHub web app. Replaces Signal.
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "GitHub", "omarchy-launch-webapp https://github.com")

-- eBay web app. Replaces the default HEY (hey.com) binding.
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "eBay", "omarchy-launch-webapp https://www.ebay.com")

-- Amazon web app. Replaces the default ChatGPT binding.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Amazon", "omarchy-launch-webapp https://www.amazon.com")

-- ChatGPT, moved off SUPER + SHIFT + A to make room for Amazon.
o.bind("SUPER + SHIFT + Z", "ChatGPT", "omarchy-launch-webapp https://chatgpt.com")

-- Free keys, no unbind needed.
o.bind("SUPER + D", "Discord", "omarchy-launch-webapp https://discord.com/channels/@me")
o.bind("SUPER + C", "Claude", "omarchy-launch-webapp https://claude.ai")
o.bind("SUPER + M", "Mbito PM", "omarchy-launch-webapp https://mbitopm.com")
```

`SUPER + C` was Omarchy's universal copy, which sends `CTRL + C` to normal windows and `CTRL + Insert` to terminals. Claude takes that key now. `CTRL` sits next to `SUPER`, so plain `CTRL + C` is still one finger away. Move Claude to `SUPER + SHIFT + C` if this becomes annoying.

HEY is Basecamp's email service at hey.com. Basecamp built Omarchy, so several Basecamp products ship as default web apps.

The browser hotkey needs no override. Omarchy's default calls the system default browser, so changing that setting is enough. See the app setup notes.

### Back up this file

```bash
cp ~/.config/hypr/bindings.lua ~/Downloads/mbito-omarchy-setup/
```

`cp` overwrites without asking. Add `-i` to be prompted.

A copy drifts every time you forget to re-run that. A symlink removes the step. The real file lives in the repo, and Hyprland reads through the link:

```bash
mv ~/.config/hypr/bindings.lua ~/Downloads/mbito-omarchy-setup/
ln -s ~/Downloads/mbito-omarchy-setup/bindings.lua ~/.config/hypr/bindings.lua
```

Move the repo out of `~/Downloads` before you commit to this. `~/dotfiles` or `~/code` is a safer home.

### Default web app hotkeys

These are Omarchy's defaults on a fresh install, before the overrides above are applied.

| Key | App |
|---|---|
| `SUPER + SHIFT + A` | ChatGPT |
| `SUPER + SHIFT + E` | HEY |
| `SUPER + SHIFT + ALT + A` | Grok |
| `SUPER + SHIFT + ALT + G` | WhatsApp |
| `SUPER + SHIFT + CTRL + G` | Google Messages |
| `SUPER + SHIFT + P` | Google Photos |
| `SUPER + SHIFT + S` | Google Maps |
| `SUPER + SHIFT + X` | X |
| `SUPER + SHIFT + ALT + X` | X, new post |
| `SUPER + SHIFT + Y` | YouTube |

Preinstalled web apps without a default hotkey include Basecamp, Google Contacts, Zoom, and Figma. Reach them through the launcher at `SUPER + SPACE`, or bind them yourself.

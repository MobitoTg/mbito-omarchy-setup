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

```lua
hl.unbind("SUPER + N")
o.bind("SUPER + N", "Editor", "code")

hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "GitHub", "omarchy-launch-webapp https://github.com")

o.bind("SUPER + D", "Discord", "omarchy-launch-webapp https://discord.com/channels/@me")
o.bind("SUPER + C", "Claude", "omarchy-launch-webapp https://claude.ai")
o.bind("SUPER + M", "Mbito PM", "omarchy-launch-webapp https://mbitopm.com")
```

`SUPER + SHIFT + G` was Signal. GitHub takes it now.

`SUPER + C` was Omarchy's universal copy, which sends `CTRL + C` to normal windows and `CTRL + Insert` to terminals. Claude takes that key now. `CTRL` sits next to `SUPER`, so plain `CTRL + C` is still one finger away. Move Claude to `SUPER + SHIFT + C` if this becomes annoying.

### Default web app hotkeys

| Key | App |
|---|---|
| `SUPER + SHIFT + A` | ChatGPT |
| `SUPER + SHIFT + ALT + A` | Grok |
| `SUPER + SHIFT + ALT + G` | WhatsApp |
| `SUPER + SHIFT + CTRL + G` | Google Messages |
| `SUPER + SHIFT + P` | Google Photos |
| `SUPER + SHIFT + S` | Google Maps |
| `SUPER + SHIFT + X` | X |
| `SUPER + SHIFT + ALT + X` | X, new post |
| `SUPER + SHIFT + Y` | YouTube |

Preinstalled web apps without a default hotkey include Basecamp, Google Contacts, Zoom, and Figma. Reach them through the launcher at `SUPER + SPACE`, or bind them yourself.
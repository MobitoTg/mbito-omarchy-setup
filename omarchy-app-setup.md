# Omarchy App Setup

Installing packages, setting the default browser, turning on dictation, and configuring NordVPN. Companion to the keybindings notes.

---

## 1. Installing packages

**Omarchy wrapper.** Covers the official repos and the AUR. This is what the menu calls:

```bash
omarchy-pkg-add package-name
```

**yay.** Same coverage, direct. Use this when you want to see build output and PKGBUILD prompts:

```bash
yay -S package-name
```

Do not put `sudo` in front of `yay`. It calls `sudo` itself at the install step, and building as root is a bad idea.

Search before installing:

```bash
yay -Ss keyword
```

**pacman.** Official repos only, and it needs `sudo`:

```bash
sudo pacman -S github-cli
```

### The package name is not always the command

```bash
yay -S google-chrome
which google-chrome-stable
```

The package is `google-chrome`. The binary is `google-chrome-stable`. Check with `which` after any install before you write the name into a script or a binding.

---

## 2. Default browser

Omarchy's browser hotkey calls the system default rather than naming a browser directly. Change the default and the existing hotkey follows.

Check what is set:

```bash
xdg-settings get default-web-browser
```

Set it:

```bash
xdg-settings set default-web-browser google-chrome.desktop
```

---

## 3. Dictation

Dictation is opt-in. The keybinding ships by default, the binary does not, so a fresh machine returns `voxtype: command not found`.

Install through the Omarchy menu: `SUPER + ALT + SPACE`, then **Install > AI > Dictation**. That pulls a base English model of about 150MB and sets up the service.

To dictate, **hold F9** and talk. The text lands in whatever input has focus.

There is also a toggle on `SUPER + CTRL + X`, but it has a known bug. Releasing Ctrl and Super before X aborts the dictation. Use F9.

Pick a different model:

```bash
voxtype setup model
```

All settings live in `~/.config/voxtype/config.toml`.

---

## 4. NordVPN

**There is no GUI.** NordVPN on Linux is CLI only. No window, no tray icon, nothing in the launcher.

Confirm the install:

```bash
which nordvpn
pacman -Q | grep -i nord
```

If the package shows but `which` comes up empty, the shell has not rehashed. Open a new terminal.

The CLI talks to a daemon, and it errors on everything if that daemon is down:

```bash
systemctl status nordvpnd
```

Start it and enable it at boot:

```bash
sudo systemctl enable --now nordvpnd
```

Add yourself to the `nordvpn` group. This takes effect at next login, not immediately:

```bash
sudo usermod -aG nordvpn $USER
```

Then check your account and connect:

```bash
nordvpn account
nordvpn login
nordvpn status
nordvpn connect
```

Bare `connect` picks the fastest nearby server. Add a country or city to override:

```bash
nordvpn connect united_states
nordvpn connect atlanta
```

Optional hotkey, since there is no app to open:

```lua
-- NordVPN connect. No GUI exists, so this runs the CLI in a terminal.
o.bind("SUPER + SHIFT + V", "VPN Connect", "alacritty -e nordvpn connect")
```

---

## 5. Trackpad right click

Three ways, on a ThinkPad clickpad:

- Two fingers on the pad, then click or tap. This is the libinput default.
- Click the bottom-right corner. The driver splits the one physical button into zones.
- The right button of the three above the pad, if you use the TrackPoint.

If two-finger click does nothing, tap-to-click is off. Add this to the touchpad block in `~/.config/hypr/input.lua`:

```lua
natural_scroll = false,
tap = true,
clickfinger_behavior = true,
```

`clickfinger_behavior` makes finger count decide the button instead of position. Turn it off to use the corner zones instead.

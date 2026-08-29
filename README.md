# mbito Omarchy Setup

My personal [Omarchy](https://omarchy.org) configuration and notes — kept here so I can link to it from my blog post about switching to Omarchy. Feel free to borrow anything that's useful for your own setup.

## Table of Contents

- [What's in this repo](#whats-in-this-repo)
- [Custom keybindings](#custom-keybindings)
- [Setup guide](#setup-guide)
- [Blog post](#blog-post)

## What's in this repo

| File | Description |
|---|---|
| [`mbito-bindings.lua`](./mbito-bindings.lua) | My personal Hyprland/Omarchy keybinding overrides — drop-in replacement for `~/.config/hypr/bindings.lua`. |
| [`omarchy-keybindings.md`](./omarchy-keybindings.md) | Step-by-step reference for installing apps, finding launch commands, checking existing keybindings, and adding/changing bindings in Omarchy. |
| [`omarchy-app-setup.md`](./omarchy-app-setup.md) | Notes on installing packages, setting the default browser, dictation, NordVPN, and trackpad right-click. |

## Custom keybindings

A quick summary of what I've changed from the Omarchy defaults (full details and reasoning in [`mbito-bindings.lua`](./mbito-bindings.lua)):

| Key | App | Notes |
|---|---|---|
| `SUPER + SHIFT + N` | Editor (VS Code) | Replaces the default editor binding |
| `SUPER + D` | Discord | New binding |
| `SUPER + SHIFT + C` | Claude | New binding |
| `SUPER + M` | Mbito PM | New binding |
| `SUPER + SHIFT + G` | GitHub | Replaces the default Signal binding |
| `SUPER + SHIFT + E` | eBay | Replaces the default HEY binding |
| `SUPER + SHIFT + A` | Amazon | Replaces the default ChatGPT binding |
| `SUPER + SHIFT + Z` | ChatGPT | Moved here to make room for Amazon |

## Setup guide

[`omarchy-keybindings.md`](./omarchy-keybindings.md) walks through the general workflow for customizing Omarchy keybindings:

1. Installing an app (native package or web app)
2. Finding the real launch command behind a `.desktop` entry
3. Checking what a key is already bound to before you claim it
4. Adding or changing a binding in `mbito-bindings.lua`, and troubleshooting if it doesn't take

[`omarchy-app-setup.md`](./omarchy-app-setup.md) covers everything else: installing packages, setting the default browser, dictation, NordVPN, and trackpad right-click.

## Blog post

I'm writing up my experience switching to Omarchy — first impressions, the keybinding changes above, and the workspace efficiency gains I'm noticing. Link coming soon.

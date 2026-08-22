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
| [`bindings.lua`](./bindings.lua) | My personal Hyprland/Omarchy keybinding overrides — drop-in replacement for `~/.config/hypr/bindings.lua`. |
| [`setup.md`](./setup.md) | Step-by-step reference for installing apps, finding launch commands, checking existing keybindings, and adding/changing bindings in Omarchy. |

## Custom keybindings

A quick summary of what I've changed from the Omarchy defaults (full details and reasoning in [`bindings.lua`](./bindings.lua)):

| Key | App | Notes |
|---|---|---|
| `SUPER + SHIFT + N` | Editor (VS Code) | Replaces the default editor binding |
| `SUPER + D` | Discord | New binding |
| `SUPER + C` | Claude | Takes over the universal-copy key (plain `CTRL + C` still works, just one key over) |
| `SUPER + M` | Mbito PM | New binding |
| `SUPER + SHIFT + G` | GitHub | Replaces the default Signal binding |

## Setup guide

[`setup.md`](./setup.md) walks through the general workflow for customizing Omarchy keybindings:

1. Installing an app (native package or web app)
2. Finding the real launch command behind a `.desktop` entry
3. Checking what a key is already bound to before you claim it
4. Adding or changing a binding in `bindings.lua`, and troubleshooting if it doesn't take

## Blog post

I'm writing up my experience switching to Omarchy — first impressions, the keybinding changes above, and the workspace efficiency gains I'm noticing. Link coming soon.

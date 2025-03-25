# topongo's dotfiles
[`tuckr`](https://github.com/RaphGL/tuckr)-managed dotfiles collection.

## List of config groups
Some application are listed but ~~stokethrough~~, that means i'm not actively using them (so they're probably outdated)

- alacritty
- bin (simple scripts)
- bookmarks (gtk-based file managers will read them)
- ~~conky~~
- eww
- fusuma
- git (configs and funny aliases)
- hypr
  - hyprland
  - hyprpaper
  - hypridle
  - hyprlock
- ~~i3~~
- joshuto
- mpv
- nvim (merged from [topongo/nvim](https://github.com/topongo/nvim))
- ~~picom~~
- ~~polybar~~
- rofi
- ~~x11~~ (.xsession and other stuff)
- xdg (xdg dirs and mime applications)
- zellij
- zsh

## `symlinks` group
The config group symlinks is special: it contains a dummy file, it does nothing but adding symlinks to the home directory. I use it to have quick access to directories deep in my folder tree with just a `cd uni`.

## History
- This repo originates from topongo/de (now private archive, for privacy reasons), that has been merged in this one on 2025/01/08  
- On 2025/03/25 I migrated it from a custom deployment using [init.sh](https://github.com/topongo/dotfiles/blob/d49b3afaac2bf24fe7d17019fd146eb6f11f8fea/init.sh) to the `tuckr` GNU Stow replacement.  
- On the same day I merged [topongo/nvim](https://github.com/topongo/nvim) into this repo.


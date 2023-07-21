# dotfiles
Collection of my customized dot files.

## Installation

### Packages
- bspwm
- sxhkd
- picom
- rofi
- feh
- mpv
- alacritty
- cmus
- lf
- neovim
- zathura
- xsecurelock
- dunst
- lemonbar (XFT)
- iwd

### Fonts
- [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)
- [scientifica](https://github.com/nerdypepper/scientifica)
- [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts)

### Setup
```bash
git clone https://github.com/rramiachraf/dotfiles
cp dotfiles/* ~/.config/ -r
rm -rf dotfiles
echo 'export PATH=$PATH:$HOME/.config/rofi' >> $HOME/.bash_profile
```

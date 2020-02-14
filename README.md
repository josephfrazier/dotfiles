Use [homeshick](https://github.com/andsens/homeshick) to install locally:

```shell
git clone https://github.com/andsens/homeshick $HOME/.homesick/repos/homeshick
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
source .bashrc
homeshick clone https://github.com/josephfrazier/dotfiles # When starting from scratch
# You'll probably want to start by installing homebrew and running `brew bundle`: https://brew.sh/

homeshick pull dotfiles # To update it with the remote changes
```
See here for more info: https://waiting-for-dev.github.io/blog/2014/05/04/distributable-and-organized-dotfiles-with-homeshick-and-mr/

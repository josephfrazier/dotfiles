Use [homeshick](https://github.com/andsens/homeshick) to install locally:

```shell
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
source .bashrc
homeshick clone https://github.com/joseph-onsip/dotfiles # When starting from scratch
homeshick pull dotfiles # To update it with the remote changes
```
See here for more info: https://waiting-for-dev.github.io/blog/2014/05/04/distributable-and-organized-dotfiles-with-homeshick-and-mr/

# dotfiles #
My various dotfiles.

## setup ##

Simple dotfile management with gnu stow and git.

from home directory
```git clone https://github.com/jmhayes3/dotfiles.git
```

change to dotfiles directory

```cd ~/dotfiles
```

install dotfiles(symlink files to `~` using stow)

```stow vim tmux bash inputrc git

# requested by `brew doctor`
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# http://stackoverflow.com/a/14970926
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Extended globbing, such as using `!(vendor)` to match everything but the vendor/ directory
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# vim with multiple files in tabs:
# `vim file1 file2 file3`
alias vim='vim -p'

# vim, but set the gitgutter diff to the argument commit and open all the changed files
# For example, to open all the files changed by the last commit:
# `vimd @`
# You can also run without arguments to open the files that have been changed since the last commit (i.e. unstaged changes)
function vimd () {
  cd $(git rev-parse --show-toplevel)
  vim -c "let g:gitgutter_diff_base = '${1:-HEAD}'" $(git diff --diff-filter=d --name-only ${1:-HEAD} ${@:2})
  cd -
}

function vimdh () {
  vimd HEAD^ $@
}

function vimdu () {
  vimd @{upstream}
}

function vimdm () {
  git branch | grep ' main$' > /dev/null && default_branch=main || default_branch=master
  vimd $default_branch... ${@:1}
}

function vimag () {
  local files="$(ag -l "$@")"
  vim "+/\\c\\v$1" $files
}

function vimdag () {
  git branch | grep ' main$' > /dev/null && default_branch=main || default_branch=master
  local files="$(git diff $default_branch... --name-only | xargs ag -l "$@")"
  vim "+/\\c\\v$1" $files
}

function vimgrep () {
  local files="$(git grep -il "$@")"
  vim "+/\\c\\v$1" $files
}

export PATH="/home/josephfrazier/.linuxbrew/bin:$PATH"
export PATH="/home/josephfrazier/.linuxbrew/sbin:$PATH"
export MANPATH="/home/josephfrazier/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/josephfrazier/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="/home/josephfrazier/.linuxbrew/share:$XDG_DATA_DIRS"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

eval $(thefuck --alias)

# alias pbcopy='xclip -selection clipboard'
# alias pbpaste='xclip -selection clipboard -o'
alias pbedit='pbpaste | vipe | pbcopy'
alias pbjq='pbpaste | jq'
alias be='bundle exec'
alias cat=bat # https://github.com/sharkdp/bat

export PATH="$HOME/.yarn/bin:$PATH"

export ANDROID_HOME=~/android-sdk

set -o vi

# Create a GitHub pull request to the `origin` remote.
# Requires `hub`: https://github.com/github/hub
function pullrequest () {
  (
    set -euo pipefail

    pushd $(git root)

    # Make sure we have a fork.
    git remote | grep josephfrazier > /dev/null || hub fork
    # Push the current branch up to the fork
    git push --set-upstream josephfrazier $(git rev-parse --abbrev-ref HEAD)
    # Find default branch
    git branch | grep ' main$' > /dev/null && default_branch=main || default_branch=master
    # Use concatenated commit messages as PR title/body
    git log --format=%B $default_branch.. --reverse > .git/PULLREQ_EDITMSG
    # Live-preview the rendered pull request markdown
    vmd .git/PULLREQ_EDITMSG &
    # Open the pull request
    hub pull-request --browse -b $default_branch --draft $@
    # Close the markdown preview
    ps aux | grep '[v]md/main/main.js .git/PULLREQ_EDITMSG' | awk '{ print $2 }' | xargs kill -9

    popd
  )
}


# added by travis gem
[ -f /home/josephfrazier/.travis/travis.sh ] && source /home/josephfrazier/.travis/travis.sh

function dotenv () {
  set -o allexport
  source .env
  set +o allexport
}

[ -s "/usr/share/autojump/autojump.sh" ] && \. "/usr/share/autojump/autojump.sh"  # This loads autojump

# alias open=xdg-open

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# from `brew install golang`:
#
# A valid GOPATH is required to use the `go get` command.
# If $GOPATH is not specified, $HOME/go will be used by default:
#   https://golang.org/doc/code.html#GOPATH
#
# You may wish to add the GOROOT-based install location to your PATH:
#   export PATH=$PATH:/home/josephfrazier/.linuxbrew/opt/go/libexec/bin
export PATH=$PATH:$HOME/go/bin

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/josephfrazier/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

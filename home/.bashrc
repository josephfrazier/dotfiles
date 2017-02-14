alias ls='ls -Gph'
alias chrome='open -a "Google Chrome"'
alias google-chrome='open -a "Google Chrome"'
alias vi='vim -p'
alias vim='vim -p'
alias grep='grep --colour=auto'
alias sftp='rlwrap sftp'
stty -ixon # allows ctrl-s to do the opposite of ctrl-r, that is, go forwards
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias less='less -R' # preserve colors
alias vlc='open -a vlc'
alias dockerquickstart="bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
# https://ask.wireshark.org/questions/38570/1991-os-x-and-multiple-windows/38581
alias wireshark="open -n /Applications/Wireshark.app"
# https://onsip.slack.com/archives/D0993HJNR/p1461950515000002
alias jitsi="/Applications/Jitsi.app/Contents/MacOS/Jitsi -m > /dev/null 2>&1 &"
alias csshx="i2cssh -b"
alias npmreinstall="rm -rf node_modules && npm install"

function vimd () {
  cd $(git rev-parse --show-toplevel)
  vim $(git diff --name-only ${1:-HEAD} ${@:2})
  cd -
}

function dotenv () {
  set -o allexport
  source .env
  set +o allexport
}

function gitremoteurl () {
  git remote -v | awk '{print $2}'
}

# http://www.reddit.com/r/commandline/comments/ocawp/git_status_check_in_bash_prompt/c3g6w6t
source ~/.bash/vcs
export PS1="${GREEN_BOLD}[\u@\h \w]${RESET} \$(git_output)\\$\n"

# https://sites.google.com/a/chromium.org/dev/developers/how-tos/install-depot-tools
export PATH=$HOME/workspace/depot_tools:$PATH
# needed by `cargo install rustfmt`
export PATH=$HOME/.cargo/bin:$PATH

# https://hub.github.com/
alias git=hub

# Create a GitHub pull request to the `origin` remote.
# Requires `hub`: https://github.com/github/hub
function pullrequest () {
  # Make sure we have a fork.
  git remote | grep josephfrazier > /dev/null || hub fork
  # Push the current branch up to the fork
  git push --set-upstream josephfrazier $(git rev-parse --abbrev-ref HEAD)
  # Open the pull request
  hub pull-request
}

set -o vi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use # This loads nvm
alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

# npm tab-completion
# https://docs.npmjs.com/cli/completion
source ~/.bash/bash_completion.d/npm

# added by travis gem
[ -f /Users/josephfrazier/.travis/travis.sh ] && source /Users/josephfrazier/.travis/travis.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# from `brew install thefuck`
alias fuck='TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1)) && eval $TF_CMD; history -s $TF_CMD'

# from `brew install chruby`
source /usr/local/opt/chruby/share/chruby/chruby.sh
# https://github.com/postmodern/chruby#auto-switching
source /usr/local/opt/chruby/share/chruby/auto.sh

source ~/.homesick/repos/homeshick/completions/homeshick-completion.bash

# from `brew install pyenv`
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# Stop `brew doctor` from complaining about pyenv *-config scripts
# https://github.com/yyuu/pyenv/issues/106#issuecomment-94921352
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

# https://github.com/clvv/fasd#install
eval "$(fasd --init auto)"

# colorize man pages
# https://news.ycombinator.com/item?id=12296402
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\x1b[38;2;255;200;200m") \
		LESS_TERMCAP_md=$(printf "\x1b[38;2;255;100;200m") \
		LESS_TERMCAP_me=$(printf "\x1b[0m") \
		LESS_TERMCAP_so=$(printf "\x1b[38;2;60;90;90;48;2;40;40;40m") \
		LESS_TERMCAP_se=$(printf "\x1b[0m") \
		LESS_TERMCAP_us=$(printf "\x1b[38;2;150;100;200m") \
		LESS_TERMCAP_ue=$(printf "\x1b[0m") \
		man "$@"
}

[ -f ~/.bash/private.bash ] && source ~/.bash/private.bash

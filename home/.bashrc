export HISTCONTROL=ignoreboth
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
alias npmt="npm test"
alias pbedit="pbpaste | vipe | pbcopy"

function light () {
  echo -e "\033]50;SetProfile=light\a"
  sed --in-place --follow-symlinks 's/set background=dark/set background=light/' ~/.vimrc
}

function dark () {
  echo -e "\033]50;SetProfile=dark\a"
  sed --in-place --follow-symlinks 's/set background=light/set background=dark/' ~/.vimrc
}

function vimd () {
  cd $(git rev-parse --show-toplevel)
  vim $(git diff --diff-filter=d --name-only ${1:-HEAD} ${@:2})
  cd -
}

function vimdh () {
  vimd head^ $@
}

function vimag () {
  local command="ag -l $@"
  $command && vim +/$1 $($command)
}

function dotenv () {
  set -o allexport
  source .env
  set +o allexport
}

function gitremoteurl () {
  git remote -v | awk '{print $2}'
}

# https://sites.google.com/a/chromium.org/dev/developers/how-tos/install-depot-tools
export PATH=$HOME/workspace/depot_tools:$PATH
# needed by `cargo install rustfmt`
export PATH=$HOME/.cargo/bin:$PATH

# https://hub.github.com/
alias git=hub

# Create a GitHub pull request to the `origin` remote.
# Requires `hub`: https://github.com/github/hub
function pullrequest () {
  (
    set --euo pipefail
    # Make sure we have a fork.
    git remote | grep josephfrazier > /dev/null || hub fork
    # Push the current branch up to the fork
    git push --set-upstream josephfrazier $(git rev-parse --abbrev-ref HEAD)
    # Live-preview the rendered pull request markdown
    vmd .git/PULLREQ_EDITMSG &
    # Open the pull request
    hub pull-request --browse
    # Close the markdown preview
    ps aux | grep '[v]md/main/main.js .git/PULLREQ_EDITMSG' | awk '{ print $2 }' | xargs kill -9
  )
}

set -o vi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use # This loads nvm

export PATH="$PATH:`yarn global bin`" # https://yarnpkg.com/en/docs/install

# npm tab-completion
# https://docs.npmjs.com/cli/completion
source ~/.bash/bash_completion.d/npm

# added by travis gem
[ -f /Users/josephfrazier/.travis/travis.sh ] && source /Users/josephfrazier/.travis/travis.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# from `brew install thefuck`
function fuck () {
  TF_PREVIOUS=$(fc -ln -1);
  TF_CMD=$(
  TF_ALIAS=fuck
  TF_SHELL_ALIASES=$(alias)
  PYTHONIOENCODING=utf-8
  thefuck $TF_PREVIOUS THEFUCK_ARGUMENT_PLACEHOLDER $@
  ) && eval $TF_CMD;
  history -s $TF_CMD;
}

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

# http://www.reddit.com/r/commandline/comments/ocawp/git_status_check_in_bash_prompt/c3g6w6t
source ~/.bash/vcs
export PS1="${GREEN_BOLD}[\u@\h \w]${RESET} \$(git_output)\\$\n"

[ -f ~/.bash/private.bash ] && source ~/.bash/private.bash

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[ -f /Users/josephfrazier/.config/yarn/global/node_modules/tabtab/.completions/yarn.bash ] && . /Users/josephfrazier/.config/yarn/global/node_modules/tabtab/.completions/yarn.bash

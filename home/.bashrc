alias ls='ls -Gph'
alias chrome='open -a "Google Chrome"'
alias google-chrome='open -a "Google Chrome"'
alias vi='vim -p'
alias vim='vim -p'
alias grep='grep --colour=auto'
alias sftp='rlwrap sftp'
stty -ixon # allows ctrl-s to do the opposite of ctrl-r, that is, go forwards
alias updatedb='sudo /usr/libexec/locate.updatedb'
# http://raamdev.com/2008/howto-install-md5sum-sha1sum-on-mac-os-x/
alias md5sum='md5 -r'
alias less='less -R' # preserve colors
alias vlc='open -a vlc'
alias dockerquickstart="bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
# https://ask.wireshark.org/questions/38570/1991-os-x-and-multiple-windows/38581
alias wireshark="open -n /Applications/Wireshark.app"
# https://onsip.slack.com/archives/D0993HJNR/p1461950515000002
alias jitsi="/Applications/Jitsi.app/Contents/MacOS/Jitsi -m > /dev/null 2>&1 &"
alias csshx="i2cssh -b"

function gitremoteurl () {
  git remote -v | awk '{print $2}'
}

# http://www.reddit.com/r/commandline/comments/ocawp/git_status_check_in_bash_prompt/c3g6w6t
source ~/.bash/vcs
export PS1="${GREEN_BOLD}[\u@\h \w]${RESET} \$(git_output)\\$\n"

export ANDROID_HOME=$HOME/adt-bundle-mac-x86_64-20140321/sdk
export PATH=$HOME/adt-bundle-mac-x86_64-20140321/sdk:$PATH
export PATH=$HOME/adt-bundle-mac-x86_64-20140321/sdk/tools:$PATH
export PATH=$HOME/adt-bundle-mac-x86_64-20140321/sdk/platform-tools:$PATH
# https://sites.google.com/a/chromium.org/dev/developers/how-tos/install-depot-tools
export PATH=$HOME/workspace/depot_tools:$PATH

# https://hub.github.com/
alias git=hub

set -o vi

export NVM_DIR="/Users/josephfrazier/.nvm"
source ~/.nvm/nvm.sh

# npm tab-completion
# https://docs.npmjs.com/cli/completion
source ~/.bash/bash_completion.d/npm

# added by travis gem
[ -f /Users/josephfrazier/.travis/travis.sh ] && source /Users/josephfrazier/.travis/travis.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# from `brew install thefuck`
eval "$(thefuck --alias)"

# Use Firefox Developer Edition with `web-ext`
# https://github.com/mozilla/web-ext/blob/a6c5004bbb1edb8628c9c0230c7560094c64417e/src/program.js#L143
export WEB_EXT_FIREFOX_BINARY=/Applications/FirefoxDeveloperEdition.app/Contents/MacOS/firefox-bin

# from `brew install chruby`
source /usr/local/opt/chruby/share/chruby/chruby.sh
# https://github.com/postmodern/chruby#auto-switching
source /usr/local/opt/chruby/share/chruby/auto.sh

source ~/.homesick/repos/homeshick/completions/homeshick-completion.bash

# from `brew install pyenv`
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

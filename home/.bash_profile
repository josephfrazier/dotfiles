# requested by `brew doctor`
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# # https://docs.brew.sh/Shell-Completion
# if type brew &>/dev/null; then
#   HOMEBREW_PREFIX="$(brew --prefix)"
#   if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
#     source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#   else
#     for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
#       [[ -r "$COMPLETION" ]] && source "$COMPLETION"
#     done
#   fi
# fi
export HOMEBREW_NO_AUTO_UPDATE=1

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

eval "$(rbenv init - bash)"

# from `brew install rbenv`
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

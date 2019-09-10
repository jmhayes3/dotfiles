# ~/.bash_profile

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# virtualenv
export WORKON_HOME=~/Virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# iterm2 shell integration
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# powerline-shell
# function _update_ps1() {
#     PS1=$(powerline-shell $?)
# }

# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi


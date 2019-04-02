# ~/.bash_profile

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# iterm2 shell integration
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# added by Anaconda3 5.1.0 installer
export PATH="/anaconda3/bin:$PATH"

export WORKON_HOME=~/Virtualenvs
source /anaconda3/bin/virtualenvwrapper.sh

# powerline-shell
# function _update_ps1() {
#     PS1=$(powerline-shell $?)
# }

# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

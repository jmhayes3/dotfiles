# ~/.bashrc

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f ~/.bash-powerline.sh ]; then
  source ~/.bash-powerline.sh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

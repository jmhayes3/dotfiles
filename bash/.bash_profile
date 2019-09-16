# ~/.bash_profile

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# virtualenv
export WORKON_HOME=~/Virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# java
# export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=$(/usr/libexec/java_home -v 11) # select specific version

# javafx modules path for java versions >10
export PATH_TO_FX=$HOME/.local/share/javafx-sdk-11.0.2/lib

# javafx jmods path for java versions >10
# export PATH_TO_FX_MODS=$HOME/.local/share/javafx-jmods-11

# fzf
# use fd instead of find as search command and include hidden files
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

# use fd and include hidden files in search when using CTRL-T
export FZF_CTRL_T_COMMAND='fd --type f --hidden'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jmh/.local/share/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jmh/.local/share/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jmh/.local/share/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jmh/.local/share/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


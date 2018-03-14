# ~/.bash_aliases

set -o vi

# virtualenvwrapper
# source /anaconda/bin/virtualenvwrapper.sh

# display hidden files in fzf
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g "" --silent'
# export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -g "" --silent'

# source fzf
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# disable terminal suspend/resume
stty -ixon

shopt -s checkwinsize
shopt -s expand_aliases
# shopt -s checkjobs # gnu
shopt -s histappend
shopt -s cmdhist
# shopt -s globstar # gnu
shopt -s dotglob
shopt -s extglob
# shopt -s autocd # gnu
shopt -s cdspell
# shopt -s dirspell # gnu

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="history*:fc*:exit"
HISTSIZE=1000
HISTFILESIZE=1000

# prompt
# export PS1="\[\033[00;39m\]\[\033[00;39m\]\u\[\033[00;39m\]@\[\033[00;39m\]\h\\\
# [\033[00;39m\][\[\033[00;39m\]\w\[\033[00;39m\]]\[\033[00;39m\]$ \[\033[00m\]"

#if [ -x /usr/bin/vim ]; then
#    export VISUAL=/usr/bin/vim
#fi

#if [ -x /Applications/Google\ Chrome.app ]; then
#    export BROWSER=/Applications/Google\ Chrome.app
#fi

alias ls='ls -h'
alias ll='ls -lh'
alias la='ls -Alh'
alias lr='ls -R'
alias lra='ls -AR'
alias lt='tree'
alias lta='tree -a'
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias df='df -Th'
alias dfa='df -Tha'
alias du='du -ach'
alias chmod='chmod -v'
alias free='free -hmt'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias c='clear'
alias cls='clear'
alias ping='ping -c 5'
alias dmesg='dmesg --color'
alias tmux='tmux -2'
# alias psg='ps -aux | grep -v grep | grep -i -e VSZ -e' # gnu
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e' # bsd
alias o='open'

function download() {
  curl -O $1
}

alias dl='download'

# recursively encrypt files in directory
function encdir() {
    gpgdir -e $1 -S --Wipe
}

# recursively decrypt files in directory
function decdir() {
    gpgdir -d $1 -S
}

# archive file or folder
function compress()
{
  dirPriorToExe=`pwd`
  dirName=`dirname $1`
  baseName=`basename $1`

  if [ -f $1 ] ; then
    echo "It was a file change directory to $dirName"
    cd $dirName
    case $2 in
      tar.bz2)
        tar cjf $baseName.tar.bz2 $baseName
        ;;
      tar.gz)
        tar czf $baseName.tar.gz $baseName
        ;;
      gz)
        gzip $baseName
        ;;
      tar)
        tar -cvvf $baseName.tar $baseName
        ;;
      zip)
        zip -r $baseName.zip $baseName
        ;;
      *)
        echo "Method not passed compressing using tar.bz2"
        tar cjf $baseName.tar.bz2 $baseName
        ;;
    esac
    echo "Back to directory $dirPriorToExe"
    cd $dirPriorToExe
  else
    if [ -d $1 ] ; then
      echo "It was a directory change directory to $dirName"
      cd $dirName
      case $2 in
        tar.bz2)
          tar cjf $baseName.tar.bz2 $baseName
          ;;
        tar.gz)
          tar czf $baseName.tar.gz $baseName
          ;;
        gz)
          gzip -r $baseName
          ;;
        tar)
          tar -cvvf $baseName.tar $baseName
          ;;
        zip)
          zip -r $baseName.zip $baseName
          ;;
        *)
          echo "Method not passed compressing using tar.bz2"
          tar cjf $baseName.tar.bz2 $baseName
          ;;
      esac
      echo "Back to directory $dirPriorToExe"
      cd $dirPriorToExe
    else
      echo "'$1' is not a valid file/folder"
    fi
  fi
  echo "Done"
  echo "###########################################"
}

# Extract archives - use: extract <file>
function extract()
{
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) [ -z $commands[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
    (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
      && tar --lzma -xvf "$1" \
      || lzcat "$1" | tar xvf - ;;
  (*.tar) tar xvf "$1" ;;
  (*.gz) [ -z $commands[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
  (*.bz2) bunzip2 "$1" ;;
  (*.xz) unxz "$1" ;;
  (*.lzma) unlzma "$1" ;;
  (*.Z) uncompress "$1" ;;
  (*.zip|*.war|*.jar|*.sublime-package) unzip "$1" -d $extract_dir ;;
  (*.rar) unrar x -ad "$1" ;;
  (*.7z) 7za x "$1" ;;
  (*.deb)
    mkdir -p "$extract_dir/control"
    mkdir -p "$extract_dir/data"
    cd "$extract_dir"; ar vx "../${1}" > /dev/null
    cd control; tar xzvf ../control.tar.gz
    cd ../data; tar xzvf ../data.tar.gz
    cd ..; rm *.tar.gz debian-binary
    cd ..
    ;;
  (*)
    echo "extract: '$1' cannot be extracted" 1>&2
    success=1
    ;;
esac

(( success = $success > 0 ? $success : $? ))
(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
shift
  done
}

# show preview for txt files in fzf
function fzfp ()
{
  fzf --preview 'less {}'
}

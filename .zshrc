# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

####
#### oh-my-zsh setup
####

# Path to your oh-my-zsh installation.
export ZSH=/Users/elias/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="geometry/geometry"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"



####
#### Custom Config
####
# History
export HISTSIZE=10000
export SAVEHIST=10000

# Theme customisation
PROMPT_GEOMETRY_EXEC_TIME=true
PROMPT_GEOMETRY_COLORIZE_ROOT=true
GEOMETRY_PROMPT_SUFFIX="> "


###
# System
###
alias sz='source ~/.zshrc'
alias g8='nocorrect g8'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias v='vim'
alias vrc='code ~/.vim/vimrc'
alias zrc='code ~/.zshrc'
alias rmrf='rm -rf '
alias edit='code .'
alias xsm='exercism'

mkdirc() {
  mkdir -p $1 && cd $1
}

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}


###
# Web
###
alias myip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias fdns='dscacheutil -flushcache'
alias lstn='lsof -i | grep LISTEN'
alias hosts='nano /etc/hosts'


###
# Apache
###
alias apache.host='nano /etc/apache2/httpd.conf'
alias apache.vhost='nano /etc/apache2/extra/httpd-vhost.conf'
alias apache.restart='sudo apachectl graceful'


###
# Node.js
###
alias nr='npm run'
alias nb='node --inspect=9292 --debug-brk'
alias ni='node --inspect=9292 --debug'


###
# nvm
###
# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(whence -w __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi


###
# Python
###
alias py='python '
alias pyv='python -m virtualenv '
alias pyvs='python -m virtualenv --system-site-packages '
alias pyva='source ./bin/activate'
alias pyvd='source deactivate'
alias pi='pip3 install '
alias pi2='pip install '
alias setupvenv='source /usr/local/bin/virtualenvwrapper.sh'

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/wk
# Don't bother initialising virtualenv
# Do this manually if python is needed
## source /usr/local/bin/virtualenvwrapper.sh


###
# Rust
###
alias cg='cargo'
alias ru='rustup'

###
# PostgreSQL
###
export PGDATA="/usr/local/var/postgres/"
alias psql.start="pg_ctl -l /dev/null start"
alias psql.stop="pg_ctl stop"
alias psql.restart="pg_ctl -l /dev/null restart"


###
# ZSH Options
###
setopt auto_cd
setopt append_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt complete_in_word
setopt always_to_end


###
# ZSH Bindkeys
###
bindkey "^K" kill-whole-line
bindkey "^]" end-of-line
bindkey "^[" beginning-of-line


###
# Github
###
function ggi {
  _domain="https://raw.githubusercontent.com"
  _pathname="/github/gitignore/master/${1}.gitignore"
  _file=$(curl ${_domain}${_pathname})

  _target=$(pwd)/.gitignore
  touch ${_target}
  echo "$_file" > ${_target}
}



# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(autojump git-extras git gitfast sudo)

source $ZSH/oh-my-zsh.sh

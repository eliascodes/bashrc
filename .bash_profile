#!/bin/bash
### .bash_profile

## System Utilities
# Directory traversal
alias ..="cd .."
alias ...="cd ../.."

# Preferred implementations
alias mkdir="mkdir -pv"  # Create intermediate dirs and be verbose
alias mv="mv -iv"        # Prompt user and be verbose
alias ll="ls -FGlAhp"    # Lots

# Permissions shortcuts
alias rchown="chown -R elias"
alias rchmod="chmod -R 755"

# Set autocompletion to be case insensitive
set completion-ignore-case On

# Alias expansion for sudo
alias sudo="sudo "

# Hiding and showing hidden files
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

# Cleaning .DS_Store files
alias cleanDS="find . -type f -name '*.DS_Store' -ls -delete"

# Danger
function rimraf {
  rm -rf $1
}


## Terminal Prompt
COL_BLACK="$(tput setaf 0)"
COL_RED="$(tput setaf 1)"
COL_GREEN="$(tput setaf 2)"
COL_YELLOW="$(tput setaf 3)"
COL_BLUE="$(tput setaf 4)"
COL_ORANGE="$(tput setaf 5)"
COL_MAGENTA="$(tput setaf 6)"
COL_WHITE="$(tput setaf 7)"
COL_RESET="$(tput sgr0)"
BOLD="$(tput bold)"

function __git_colour {
	local git_status="$(git status 2> /dev/null)"

	if [[ $git_status =~ .*Changes\ not\ staged.* || $git_status =~ .*Untracked\ files.* ]]; then
		echo "$(tput setaf 1)"
	elif [[ $git_status =~ .*Your\ branch\ is\ ahead\ of.* ]]; then
		echo "$(tput setaf 3)"
	elif [[ $git_status =~ .*nothing\ to\ commit.* ]]; then
		echo "$(tput setaf 2)"
	elif [[ $git_status =~ .*Changes\ to\ be\ committed.* ]]; then
		echo "$(tput setaf 5)"
	else
		echo ""
	fi
}

function __git_branch {
	local git_status="$(git status 2> /dev/null)"
	local on_branch="On branch ([^${IFS}]*)"
	local on_commit="HEAD detached at ([^${IFS}]*)"

	if [[ $git_status =~ $on_branch ]]; then
		local branch=${BASH_REMATCH[1]}
		echo "$branch"
	elif [[ $git_status =~ $on_commit ]]; then
		local commit=${BASH_REMATCH[1]}
		echo "$commit"
	else
		echo ""
	fi
}

TIME="\[${BOLD}${COL_WHITE}\]\A\[${COL_RESET}\]"
USERATHOST="\[${BOLD}${COL_BLUE}\]\u@\h\[${COL_RESET}\]"
DIR="\[${BOLD}${COL_MAGENTA}\]\W\[${COL_RESET}\]"

export PS1="${TIME} | ${USERATHOST} | ${DIR} | \[${BOLD}\$(__git_colour)\]\$(__git_branch)\[${COL_RESET}\]\n\\$ "

## Web
# Node
alias nr='npm run'
alias nb='node --inspect=9292 --debug-brk'
alias ni='node --inspect=9292 --debug'

# Setting the PATH for MySQL
PATH="/usr/local/mysql/bin:${PATH}"
export PATH

# Setting alias for MySQL server
alias mysql.server="/usr/local/mysql/support-files/mysql.server"
alias mysql.start="sudo mysql.server start"
alias mysql.stop="sudo mysql.server stop"
alias mysql.restart="sudo mysql.server restart"

# Setting the PGDATA environment variable for PostgreSQL
PGDATA="/usr/local/var/postgres/"
export PGDATA

# Postgres aliases
alias psql.start="pg_ctl -l /dev/null start"
alias psql.stop="pg_ctl stop"
alias psql.restart="pg_ctl -l /dev/null restart"

# Utilities
alias myip='curl api.ipify.org'
alias fdns='dscacheutil -flushcache'
alias listening='lsof -i | grep LISTEN'
alias apache.host='nano /etc/apache2/httpd.conf'
alias apache.vhost='nano /etc/apache2/extra/httpd-vhost.conf'
alias apache.restart='sudo apachectl graceful'
alias hosts='nano /etc/hosts'
alias chrome='open -a /Applications/Google\ Chrome.app/'
alias firefox='open -a /Applications/Firefox.app/'
alias safari='open -a /Applications/Safari.app/'

## Git
alias gst='git status'
alias gcm='git checkout master'

# add autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Profile configuration
# Directory shortcuts
alias refresh='source ${HOME}/.bash_profile'

function fac {
  local str=''
  for p in $@; do
    str=$str/$p
  done
  cd ${HOME}/wk/fac/$str
}

function wk {
  local str=''
  for p in $@; do
    str=$str/$p
  done
  cd ${HOME}/wk/$str
}

# Path configuration
export PATH="/usr/local/sbin:${PATH}"

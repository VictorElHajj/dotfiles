#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_RED
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo " $branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo " $commit"
  fi
}

PS1="\[\e[97;45m\]\033[1m \u \e[m\]\[\e[35;40m\]\[\e[m\]"
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\e[94m \w> "
PS1+="\[$COLOR_RESET\]"   # '#' for root, else '$'
export PS1

alias c='clear'
alias fuck='sudo $(history -p \!\!)'

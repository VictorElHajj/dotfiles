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

function exit_code {
 if [[ $? != 0 ]]; then
    echo -e "$COLOR_RED"
 else
    echo -e "\033[95m"
  fi
}

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


PS1="\[\e[97;45m\]\033[1m \u "
PS1+="\[\$(exit_code)\]"        # colors git status
PS1+="\[\e[40m\]\[\e[m\]"
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\e[94m \w> "
PS1+="\[$COLOR_RESET\]"   # '#' for root, else '$'
export PS1

function prompt_command {
    # FG
    #local FG_BLACK="\e[30m"
    local FG_RED="\e[31m"
    local FG_GREEN="\e[32m"
    local FG_YELLOW="\e[33m"
    local FG_BLUE="\e[34m"
    local FG_MAGENTA="\e[35m"
    #local FG_CYAN="\e[36m"
    #local FG_LGRAY="\e[37m"
    #local FG_DGRAY="\e[90m"
    #local FG_LRED="\e[91m"
    #local FG_LGREEN="\e[92m"
    #local FG_LYELLOW="\e[93m"
    local FG_LBLUE="\e[94m"
    #local FG_LMAGENTA="\e[95m"
    #local FG_LCYAN="\e[96m"
    local FG_WHITE="\e[97m"
    # BG
    local BG_BLACK="\e[40m"
    #local BG_RED="\e[41m"
    #local BG_GREEN="\e[42m"
    #local BG_YELLOW="\e[43m"
    #local BG_BLUE="\e[44m"
    local BG_MAGENTA="\e[45m"
    #local BG_CYAN="\e[46m"
    #local BG_LGRAY="\e[47m"
    #local BG_DGRAY="\e[100m"
    #local BG_LRED="\e[101m"
    #local BG_LGREEN="\e[102m"
    #local BG_LYELLOW="\e[103m"
    #local BG_LBLUE="\e[104m"
    #local BG_LMAGENTA="\e[105m"
    #local BG_LCYAN="\e[106m"
    #local BG_WHITE="\e[107m"
    # Others
    local O_BOLD="\e[1m"
    local O_RESET="\e[0m"
    
    # Main prompt
    # Username
    PS1="$O_BOLD$FG_WHITE$BG_MAGENTA \u "
    # Arrow
    PS1+="$FG_MAGENTA$BG_BLACK$O_RESET"
    
    # Git
    # Git Color
    local git_status="$(git status 2> /dev/null)"
    if [[ $git_status =~ "Your branch is ahead of" ]]; then
        PS1+="$FG_YELLOW"
    elif [[ $git_status =~ "nothing to commit" ]]; then
        PS1+="$FG_GREEN"
    else
        PS1+="$FG_RED"
    fi
    # Git branch name. (Won't work for detached)
    local git_status="$(git status 2> /dev/null)"
    local on_branch="On branch ([^${IFS}]*)"
    if [[ $git_status =~ $on_branch ]]; then
        local branch=${BASH_REMATCH[1]}
        PS1+=" $branch"
    fi
    
    # Continue main prompt
    # Current directory and >
    PS1+="$FG_LBLUE \w> $O_RESET"
    export PS1

}
export PROMPT_COMMAND=prompt_command

alias c='clear'
alias fuck='sudo $(history -p \!\!)'

. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash
. ~/.scripts/scripts.sh

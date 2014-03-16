#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    PS_SYMBOL_DARWIN=''
    PS_SYMBOL_LINUX='\$'
    PS_SYMBOL_OTHER='%'
    GIT_BRANCH_SYMBOL='  '
    GIT_BRANCH_CHANGED_SYMBOL='+ '
    GIT_NEED_PUSH_SYMBOL='⇡ '
    GIT_NEED_PULL_SYMBOL='⇣ '
    SEPARATOR=''
    SEPARATOR_THIN=''

    # Solarized colorscheme
    FG_BASE03="\[$(tput setaf 8)\]"
    FG_BASE02="\[$(tput setaf 0)\]"
    FG_BASE01="\[$(tput setaf 10)\]"
    FG_BASE00="\[$(tput setaf 11)\]"
    FG_BASE0="\[$(tput setaf 12)\]"
    FG_BASE1="\[$(tput setaf 14)\]"
    FG_BASE2="\[$(tput setaf 7)\]"
    FG_BASE3="\[$(tput setaf 15)\]"

    BG_BASE03="\[$(tput setab 8)\]"
    BG_BASE02="\[$(tput setab 0)\]"
    BG_BASE01="\[$(tput setab 10)\]"
    BG_BASE00="\[$(tput setab 11)\]"
    BG_BASE0="\[$(tput setab 12)\]"
    BG_BASE1="\[$(tput setab 14)\]"
    BG_BASE2="\[$(tput setab 7)\]"
    BG_BASE3="\[$(tput setab 15)\]"

    FG_YELLOW="\[$(tput setaf 3)\]"
    FG_ORANGE="\[$(tput setaf 9)\]"
    FG_RED="\[$(tput setaf 1)\]"
    FG_MAGENTA="\[$(tput setaf 5)\]"
    FG_MAGENTA="\[\033[0;35m\]" # foreground magenta
    FG_VIOLET="\[$(tput setaf 13)\]"
    FG_BLUE="\[$(tput setaf 4)\]"
    FG_CYAN="\[$(tput setaf 6)\]"
    FG_GREEN="\[$(tput setaf 2)\]"

    BG_YELLOW="\[$(tput setab 3)\]"
    BG_ORANGE="\[$(tput setab 9)\]"
    BG_RED="\[$(tput setab 1)\]"
    BG_MAGENTA="\[$(tput setab 5)\]"
    BG_VIOLET="\[$(tput setab 13)\]"
    BG_BLUE="\[$(tput setab 4)\]"
    BG_CYAN="\[$(tput setab 6)\]"
    BG_GREEN="\[$(tput setab 2)\]"

    DIM="\[$(tput dim)\]"
    REVERSE="\[$(tput rev)\]"
    RESET="\[$(tput sgr0)\]"
    BOLD="\[$(tput bold)\]"

    # what OS?
    case "$(uname)" in
        Darwin)
            PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    __git_info() { 
        [ -x "$(which git)" ] || return    # no git command found

        # get current branch name or short SHA1 hash for detached head
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
        [ -n "$branch" ] || return  # not a git branch

        local marks

        # branch is modified?
        [ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [0-9]\+'| grep -o '[0-9]\+')"
        local behindN="$(echo $stat | grep -o 'behind [0-9]\+' | grep -o '[0-9]\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf "$GIT_BRANCH_SYMBOL$branch$marks "
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
            local GITINFO=$(__git_info)
            if [ -n "$GITINFO" ]; then
                local BG_EXIT="$FG_BLUE"
            else
                local BG_EXIT="$FG_YELLOW"
            fi
            BG_EXIT+="$BG_GREEN$RESET$BG_GREEN"
            local FG_EXIT="$FG_GREEN"
            local EXIT_RESULT=0
        else
            local GITINFO=$(__git_info)
            if [ -n "$GITINFO" ]; then
                local BG_EXIT="$FG_BLUE"
            else
                local BG_EXIT="$FG_YELLOW"
            fi
            BG_EXIT+="$BG_RED$RESET$BG_RED"
            local FG_EXIT="$FG_RED"
            local EXIT_RESULT=1
        fi
        PS1="$BG_BASE2$FG_BASE02\t $FG_BASE2$BG_BASE02$SEPARATOR$RESET" #time
        PS1+="$BG_BASE02$FG_BASE3 \u $FG_BASE02$BG_MAGENTA$SEPARATOR$RESET" # user
        PS1+="$BG_MAGENTA$FG_YELLOW \H $FG_MAGENTA$BG_YELLOW$RESET" # host
        PS1+="$BG_YELLOW$FG_BASE02 \W $RESET" # current directory

        if [ -n "$GITINFO" ]; then
            PS1+="$FG_YELLOW$BG_BLUE$RESET" # GIT Info
            PS1+="$BG_BLUE$FG_BASE3$GITINFO$RESET" # GIT Info
        fi
        PS1+="$BG_EXIT$FG_BASE3 \l $SEPARATOR_THIN $PS_SYMBOL$RESET$FG_EXIT$RESET" # current terminal plus $
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_USER='$'
    readonly PS_SYMBOL_ROOT='#'
    readonly GIT_BRANCH_SYMBOL='»'
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Solarized colorscheme
    readonly FG_BASE03="\[$(tput setaf 8)\]"
    readonly FG_BASE02="\[$(tput setaf 0)\]"
    readonly FG_BASE01="\[$(tput setaf 10)\]"
    readonly FG_BASE00="\[$(tput setaf 11)\]"
    readonly FG_BASE0="\[$(tput setaf 12)\]"
    readonly FG_BASE1="\[$(tput setaf 14)\]"
    readonly FG_BASE2="\[$(tput setaf 7)\]"
    readonly FG_BASE3="\[$(tput setaf 15)\]"

    readonly BG_BASE03="\[$(tput setab 8)\]"
    readonly BG_BASE02="\[$(tput setab 0)\]"
    readonly BG_BASE01="\[$(tput setab 10)\]"
    readonly BG_BASE00="\[$(tput setab 11)\]"
    readonly BG_BASE0="\[$(tput setab 12)\]"
    readonly BG_BASE1="\[$(tput setab 14)\]"
    readonly BG_BASE2="\[$(tput setab 7)\]"
    readonly BG_BASE3="\[$(tput setab 15)\]"

    readonly FG_YELLOW="\[$(tput setaf 3)\]"
    readonly FG_ORANGE="\[$(tput setaf 9)\]"
    readonly FG_RED="\[$(tput setaf 1)\]"
    readonly FG_MAGENTA="\[$(tput setaf 5)\]"
    readonly FG_VIOLET="\[$(tput setaf 13)\]"
    readonly FG_BLUE="\[$(tput setaf 4)\]"
    readonly FG_CYAN="\[$(tput setaf 6)\]"
    readonly FG_GREEN="\[$(tput setaf 2)\]"

    readonly BG_YELLOW="\[$(tput setab 3)\]"
    readonly BG_ORANGE="\[$(tput setab 9)\]"
    readonly BG_RED="\[$(tput setab 1)\]"
    readonly BG_MAGENTA="\[$(tput setab 5)\]"
    readonly BG_VIOLET="\[$(tput setab 13)\]"
    readonly BG_BLUE="\[$(tput setab 4)\]"
    readonly BG_CYAN="\[$(tput setab 6)\]"
    readonly BG_GREEN="\[$(tput setab 2)\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        # get current branch name or short SHA1 hash for detached head
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead \d\+' | grep -o '\d\+')"
        local behindN="$(echo $stat | grep -o 'behind \d\+' | grep -o '\d\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    __short_dir() {
        local DIR_SPLIT_COUNT=4
        IFS='/' read -a DIR_ARRAY <<< "$PWD"
        if [ ${#DIR_ARRAY[@]} -gt $DIR_SPLIT_COUNT ]; then
            local DIR_OUTPUT="/${DIR_ARRAY[1]}/.../${DIR_ARRAY[${#DIR_ARRAY[@]}-2]}/${DIR_ARRAY[${#DIR_ARRAY[@]}-1]}"
        else
            local DIR_OUTPUT="$PWD"
        fi
        if [ "$HOME" == "$PWD" ]; then
            local DIR_OUTPUT="~"
        fi
        printf "$DIR_OUTPUT"
    }

    __short_path() {
        local SHORT_NUM=20
        if (( ${#PWD} > $SHORT_NUM )); then
            local SHORT_PATH="..${PWD: -$SHORT_NUM}"
        else
            local SHORT_PATH=$PWD
        fi
        if [ "$HOME" == "$PWD" ]; then
            local SHORT_PATH="~"
        fi
        echo $SHORT_PATH
   }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -ne 0 ]; then
            local BG_EXIT="$BG_ORANGE$FG_BASE3 $? $RESET"
        else
            local BG_EXIT=""
        fi
        # Check if root or regular user
        if [ $EUID -ne 0 ]; then
            local BG_ROOT="$BG_GREEN"
            local PS_SYMBOL=$PS_SYMBOL_USER
        else
            local BG_ROOT="$BG_RED"
            local PS_SYMBOL=$PS_SYMBOL_ROOT
        fi

        # Check if running sudo
        if [ -z "$SUDO_USER" ]; then
            local IS_SUDO=""
        else
            local IS_SUDO="$FG_YELLOW"
        fi

        # Check if ssh session
        if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
            local IS_SSH="$BG_BASE03$FG_YELLOW@\h"
        else
            local IS_SSH=""
        fi

        PS1=""
        PS1+="$BG_BASE03$FG_BASE3$IS_SUDO \u$IS_SSH $RESET"
        PS1+="$BG_BASE03$FG_BASE3 $(__short_dir) $RESET"
        #PS1+="$BG_BASE03$FG_BASE3 $(__short_path) $RESET"
        #PS1+="$BG_BASE03$FG_BASE3 \w $RESET"
        PS1+="$BG_BLUE$FG_BASE3$(__git_info)$RESET"
        PS1+="$BG_ROOT$FG_BASE3 $PS_SYMBOL $RESET"
        PS1+="$BG_EXIT"
        PS1+=" "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

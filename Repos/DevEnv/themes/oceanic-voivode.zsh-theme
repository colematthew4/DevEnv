# -----------------------------------------------------------------------------
# 
# Oceanic Voivode Terminal Theme
# 
# Author: Matthew Cole
# 
# -----------------------------------------------------------------------------

function update_command_status() {
    if [ -z ${COMMAND_RESULT+x} ]; then
	    local hasValue=false
    else
	    local hasValue=true
    fi
    COMMAND_RESULT=$1

    if ! $hasValue; then
        export COMMAND_RESULT
    fi
}
update_command_status true


# set option
setopt PROMPT_SUBST

# git
ZSH_THEME_GIT_PROMPT_DIRTY=false
ZSH_THEME_GIT_PROMPT_CLEAN=true

# define theme colors
if [ "$COLORTERM" = "truecolor" ]; then
    local -A THEME_COLORS=(
        'WHITE'     '#F8F8F2'
        'PINK'      '#FF79C6'
        'GREEN'     '#50FA78'
        'ORANGE'    '#FFB86C'
        'PURPLE'    '#BD93F9'
        'CYAN'      '#8BE9FD'
        'RED'       '#FF5555'
    )
else  # only use the built-in 3/4-bit colors
    local -A THEME_COLORS=(
        'WHITE'     'white'
        'PINK'      'magenta'
        'GREEN'     'green'
        'ORANGE'    'yellow'
        'PURPLE'    'blue'
        'CYAN'      'cyan'
        'RED'       'red'
    )
fi

function colorize_fg() {
    echo "%F{$THEME_COLORS[$2]}$1%f"
}

# command execute after
# https://zsh.sourceforge.io/Doc/zsh_us.pdf
precmd() {
    # last_cmd
    # local last_cmd_return_code=$?
    if [ "$?" = "0" ]; then
        local last_cmd_result=true
    else
        local last_cmd_result=false
    fi

    # update_command_status
    update_command_status $last_cmd_result

    printf "\n"
    if $last_cmd_result; then
	    printf "}"
    else
        # for some reason the colorize_fg function doesn't work here, so do a manual check and colorize instead
        if [ "$COLORTERM" = "truecolor" ]; then
            # the 255,85,85 is the truecolor red
	        printf "\x1b[38;2;255;85;85m}\x1b[0m\n"
        else
	        # the 0;31 is the standard red
            printf "\033[0;31m}\033[0m\n"
	    fi
    fi
    printf " \033[0;34m/**********/\033[0m\n"
}

# timer
# https://stackoverflow.com/questions/26526175/zsh-menu-completion-causes-problems-after-zle-reset-prompt
TMOUT=1
TRAPALRM() {
    # $(git_prompt_info) cost too much time which will raise stutters when inputting. so we need to disable it in this occurence.
    # if [ "$WIDGET" != "expand-or-complete" ] && [ "$WIDGET" != "self-insert" ] && [ "$WIDGET" != "backward-delete-char" ]; then
    # black list will not enum it completely. even some pipe broken will appear.
    # so we just put a white list here.
    if [ "$WIDGET" = "" ] || [ "$WIDGET" = "accept-line" ] ; then
        zle reset-prompt
    fi
}

# https://stackoverflow.com/questions/25944006/bash-current-working-directory-with-replacing-path-to-home-folder
function directory() {
    echo "${PWD/#$HOME/~}"
}

function command_status_color() {
    if $COMMAND_RESULT; then
        echo "${1:-WHITE}"
    else
        echo 'RED'
    fi
}

function set_prompt() {
    echo -n "$(colorize_fg %n PINK)"
    echo -n ' '
    echo -n "$(colorize_fg '<' $(command_status_color))"
    echo -n "$(colorize_fg %m CYAN)"
    echo -n "$(colorize_fg '>' $(command_status_color))"
    echo -n ' '
    echo -n "$(colorize_fg $(directory) $(command_status_color GREEN))"
    echo -n "$(colorize_fg '(' $(command_status_color))"

    local branch=$(git_current_branch)
    if [ -n "$branch" ]; then
        local isDirty=$(parse_git_dirty)

        if [ isDirty ]; then
            echo -n "%U"
        fi

        echo -n "$(colorize_fg $branch ORANGE)"

        if [ isDirty ]; then
            echo -n "%u"
        fi
    fi

    echo -n "$(colorize_fg ')' $(command_status_color))"
    echo -n ' '
    echo -n $(colorize_fg '{' $(command_status_color))
    echo -n '\n'
    echo -n $(colorize_fg '|||>' PINK)
    echo -n "%{$reset_color%} "
}

# set_prompt
PROMPT='$(set_prompt)'

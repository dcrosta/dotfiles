#
# colorize shell programs

# ls (platform dependent)
if [ -e /usr/local/bin/gls ]; then
    # if GNU ls is installed (e.g. on BSD), use it
    alias ls='/usr/local/bin/gls --color=tty'
    export LS_COLORS="rs=0:di=34:ln=36:pi=40;33:so=35:do=35:bd=40;33:cd=40;33:or=40;31:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=32"
else
    # otherwise, detect which version of ls is on the path
    if $(ls --color -d . &>/dev/null 2>&1); then
        alias ls='ls --color=tty'
        export LS_COLORS="rs=0:di=34:ln=36:pi=40;33:so=35:do=35:bd=40;33:cd=40;33:or=40;31:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=32"
    else
        alias ls='ls -G'
        export LSCOLORS="exgxbxdxcxegedxbxgxcxd"
    fi
fi

# less
export LESS_TERMCAP_mb=$'\e[0;31m'     # begin blinking      - red
export LESS_TERMCAP_md=$'\e[0;34m'     # begin bold          - blue
export LESS_TERMCAP_me=$'\e[0m'        # end mode
export LESS_TERMCAP_so=$'\e[30;46m'    # begin standout mode - black on cyan
export LESS_TERMCAP_se=$'\e[0m'        # end standout mode
export LESS_TERMCAP_us=$'\e[4;33m'     # begin underline     - yellow underline
export LESS_TERMCAP_ue=$'\e[0m'        # end underline

#
# make a sweet prompt

autoload colors; colors;
setopt prompt_subst # expansion of color codes, etc. in the prompt

# print the fully resolved shell command with time stamp
# to be run from zsh's builtin 'preexec' with all arguments passed through ($*)
function theme_preexec () {
    # echo "($fg[magenta]`date +%r`$reset_color) $fg[cyan]$3$reset_color"
}

# print the exit code of the previous command in red if non-zero
function return_code {
    echo "%(?..%{$fg[red]%}%?%{$reset_color%} )"
}

# print the current git branch (BRANCH)
function git_prompt_info {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "${ref#refs/heads/}"
}

# print a special prompt char in version controlled directories
function prompt_char {
    $(git diff --exit-code > /dev/null 2>&1)
    if [ $? -eq 1 ]; then
        git branch >/dev/null 2>/dev/null && echo "%{$fg[red]%}±%{$reset_color%}" && return
    else
        git branch >/dev/null 2>/dev/null && echo '±' && return
    fi
    echo '$'
}

# virtualenv
function ve_prompt_info {
    echo `basename "$VIRTUAL_ENV"` || return
}

function prompt_prefix {
    prefix="$(ve_prompt_info)@$(git_prompt_info)"
    prefix=${prefix#@}
    if [ ! -z "$prefix" ]; then
        echo "($prefix) "
    fi
}

# print the hostname in green if local, else red
function hostname_info {
    echo "%{$fg[green]%}%{$ZSH_HOST_PREFIX%}%2m%{$ZSH_HOST_SUFFIX%}%{$reset_color%}"
}

# a colorful multiline prompt using the above defined functions
PROMPT='$(prompt_prefix)%{$fg[yellow]%}%n%{$reset_color%}@$(hostname_info):%{$fg[blue]%}%~%{$reset_color%} $(prompt_char)%{$reset_color%} '
_PROMPT=$PROMPT


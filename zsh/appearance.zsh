#done

autoload colors; colors;
setopt prompt_subst # expansion of color codes, etc.

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
export LSCOLORS="exgxbxdxcxegedxbxgxcxd"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export LESS_TERMCAP_mb=$'\e[0;31m'     # begin blinking      - red
export LESS_TERMCAP_md=$'\e[0;34m'     # begin bold          - blue
export LESS_TERMCAP_me=$'\e[0m'        # end mode
export LESS_TERMCAP_so=$'\e[38;5;246m' # begin standout mode - info box
export LESS_TERMCAP_se=$'\e[0m'        # end standout mode
export LESS_TERMCAP_us=$'\e[4;33m'     # begin underline     - yellow underline
export LESS_TERMCAP_ue=$'\e[0m'        # end underline

function theme_preexec () {
    echo "($fg[magenta]`date +%r`$reset_color) $fg[cyan]$3$reset_color"
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    svn info >/dev/null 2>/dev/null && echo 'ϟ' && return
    echo '$'
}

function return_code {
    code=$(echo $?)
    if [[ $code == "0" ]]; then
        return
    else
        echo "%{$fg[red]%}$code%{$reset_color%} "
    fi
}

PROMPT='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}
$(return_code)$(git_prompt_info)$(prompt_char) %{$reset_color%}'

for config_file (~/.zsh/*.zsh) source $config_file

export EDITOR=vim

if [ -e $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

if (( $+commands[go] )); then
    eval $(go env | grep ^GO )
fi

# override builtin functions (preexec, precmd, etc.)
source ~/.zsh/functions.zsh-overrides

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

export PYTHONSTARTUP=$HOME/.pythonrc
export EDITOR=/usr/bin/vim
export PAGER="/usr/bin/less -S"


alias pyc='find . -name "*.pyc" -delete'
alias swp='find . -name ".*.swp" -delete'
alias mkvirtualenv='mkvirtualenv --no-site-packages --distribute'
alias whichvm='python -c "import json; print(json.load(file(\".vagrant\"))[\"active\"][\"default\"])"'

virtualenvwrapper=`which virtualenvwrapper.sh 2> /dev/null`
if [ -f "$virtualenvwrapper" ]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    source $virtualenvwrapper
fi


for config_file (~/.zsh/*.zsh) source $config_file

export EDITOR=vim

if (( $+commands[go] )); then
    eval $(go env | grep ^GO )
fi

# override builtin functions (preexec, precmd, etc.)
source ~/.zsh/functions.zsh-overrides

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

export PYTHONDONTWRITEBYTECODE=1
export PYTHONSTARTUP=$HOME/.pythonrc
export EDITOR=/usr/bin/vim
export PAGER="/usr/bin/less -S"

export PIP_WHEEL_DIR=$HOME/.pip/wheelhouse
export PIP_FIND_LINKS=$PIP_WHEEL_DIR


alias pyc='find . -name "*.pyc" -delete ; find . -name "__pycache__" -delete ; find . -name "_trial_temp" -delete ; find . -name ".tox" -delete'
alias swp='find . -name ".*.swp" -delete'
alias dum='sudo du -xm --max-depth=1 .'
alias cleanenv='pip uninstall -y $(pip freeze | egrep -v "(^-e|distribute|wsgiref)" | grep -v "^-f" | sed "s/>/=/g" | cut -f1 -d=)'

dotfiles() {
    ssh $1 "curl -Lk http://s.late.am/d4 | bash"
}

if [ -e $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

for config_file (~/.zsh/*.zsh) source $config_file

if (( $+commands[go] )); then
    eval $(go env | grep ^GO 2> /dev/null )
fi

# override builtin functions (preexec, precmd, etc.)
source ~/.zsh/functions.zsh-overrides

export PATH=$HOME/bin:$PATH

export PYTHONDONTWRITEBYTECODE=1
export PYTHONSTARTUP=$HOME/.pythonrc
export EDITOR=/usr/bin/vim
export PAGER="/usr/bin/less -S"


alias pyc='find . -name "*.pyc" -delete ; find . -name "__pycache__" -delete ; find . -name "_trial_temp" -delete ; find . -name ".tox" -delete'
alias dum='sudo du -xm --max-depth=1 .'
alias cleanenv='pip uninstall -y $(pip freeze | egrep -v "(^-e|appdirs|distribute|pip|pyparsing|setuptools|six|wheel|wsgiref)" | grep -v "^-f" | sed "s/>/=/g" | cut -f1 -d=)'


dotfiles() {
    ssh $1 "curl -Lk http://s.late.am/d4 | bash"
}

if [ -e $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

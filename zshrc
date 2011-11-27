for config_file (~/.zsh/*.zsh) source $config_file

export EDITOR=vim

if [ -e $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

# override builtin functions (preexec, precmd, etc.)
source ~/.zsh/functions.zsh-overrides

export PATH=$HOME/bin:$PATH:/usr/local/sbin

export PYTHONSTARTUP=$HOME/.pythonrc
export EDITOR=/usr/bin/vim
export PAGER="/usr/bin/less -S"


alias pyc='find . -name "*.pyc" -delete'
alias swp='find . -name ".*.swp" -delete'
alias mkvirtualenv='mkvirtualenv --no-site-packages'


if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then 
    export WORKON_HOME='/Users/dcrosta/.virtualenvs'
    source /usr/local/bin/virtualenvwrapper.sh
fi

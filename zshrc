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
alias mkvirtualenv='mkvirtualenv --no-site-packages --distribute'
alias codereview='python ~/dev/10gen/scratch/tools/upload.py -e dcrosta@10gen.com -s codereview.10gen.com'
alias whichvm='python -c "import json; print(json.load(file(\".vagrant\"))[\"active\"][\"default\"])"'

virtualenvwrapper=`which virtualenvwrapper.sh`
if [ -f "$virtualenvwrapper" ]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    source $virtualenvwrapper
fi


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

if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then 
    export WORKON_HOME='/Users/dcrosta/.virtualenvs'
    source /usr/local/bin/virtualenvwrapper.sh

    function mkenv {
        dir="$1"
        if [ -z "$dir" ]; then
            echo "usage: mkenv dir"
            return 1
        fi

        dir=`abspath $dir`
        name=`basename $dir`

        if [ -d "$WORKON_HOME/$name" ]; then
            echo "environment '$name' exists"
            return 1
        fi

        mkdir -p $dir
        mkvirtualenv --no-site-packages $name

        # echo "alias $name='cd $dir && workon $name'" >> $HOME/.envs.profile
        echo            >> $WORKON_HOME/$name/bin/postactivate
        echo "cd $dir"  >> $WORKON_HOME/$name/bin/postactivate

        workon $name
    }
fi

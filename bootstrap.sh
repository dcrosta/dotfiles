if [ ! -d ~/dotfiles ]; then
    cd
    git clone git://github.com/dcrosta/dotfiles.git
    cd dotfiles
    ./deploy.sh
else
    cd dotfiles
    git pull origin master
fi

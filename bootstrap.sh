if [ ! -d ~/dotfiles ]; then
    cd
    git clone git://github.com/dcrosta/dotfiles.git
    cd dotfiles
    ./deploy.sh
else
    cd dotfiles
    git pull origin master
fi

PLATFORM=`uname -s`
if [ "$PLATFORM" = "Linux" ]; then
    crontab ~/dotfiles/linux-crontab
fi

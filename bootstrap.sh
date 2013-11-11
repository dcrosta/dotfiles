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
    cp ~/dotfiles/linux-crontab ~/dotfiles/crontab.tmp
    [ -f ~/.local-crontab ] && cat ~/.local-crontab >> ~/dotfiles/crontab.tmp
    crontab ~/dotfiles/crontab.tmp
    rm -f ~/dotfiles/crontab.tmp
fi

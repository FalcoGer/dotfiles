create repository
    mkdir ~/repositories/dotfiles
    cd ~/repositories/dotfiles
    git init --bare
    remote add origin https://www.github.com/username/repo.git

alias git to bare repo
    alias config="/usr/bin/git --git-dir=$HOME/repositories/dotfiles/ --work-tree=$HOME"

set no tracking
    config config --local status.showUntrackedFiles no

add files to repository
    config add ~/.some_dotfile
    config commit
    config push

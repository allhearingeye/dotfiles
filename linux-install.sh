#!/bin/bash

vimplug=$HOME/.vim/autoload/plug.vim
undodir=$HOME/.vim/undodir

# vim install
if [[ -f "$vimplug" ]]; then
    echo "Vim-plug exists"
else
    echo "Downloading vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || exit
fi

[[ -d $undodir ]] || mkdir -p $undodir
echo "Installing..."
cp .vimrc $HOME/.vimrc
vim +"PlugInstall --sync" +qa

# tmux install
cp .tmux.conf $HOME/.tmux.conf

if [[ -n $TMUX ]]; then
    tmux source-file $HOME/.tmux.conf
    read -n1 -p "You need to restart tmux to fix colors in vim. Kill tmux? [y/n]" doit
    case $doit in
      y|Y) tmux kill-server;;
      *  ) echo -e  "\n\nDon't forget to restart tmux manually";;
    esac
fi

# Other config install
cp -R $PWD/.config $HOME/

echo "Installation complete!"
echo -e "For xkbswitch run: \nsudo cp ./utils/libxkbswitch.so /usr/local/lib/libxkbswitch.so"


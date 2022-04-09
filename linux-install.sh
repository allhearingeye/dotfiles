#!/bin/bash

vimplug=$HOME/.vim/autoload/plug.vim
undodir=$HOME/.vim/undodir

if [ -f "$vimplug" ]; then
    echo "Vim-plug exists"
else
    echo "Downloading vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || exit
fi

[ -d $undodir ] || mkdir -p $undodir
echo "Installing..."
[ -f "$HOME/.vimrc" ] && rm $HOME/.vimrc
ln -s $PWD/.vimrc $HOME/.vimrc
vim +'PlugInstall --sync' +qa
[ -f "$HOME/.tmux.conf" ] && rm $HOME/.tmux.conf
ln -s $PWD/.tmux.conf $HOME/.tmux.conf
tmux source-file $HOME/.tmux.conf
echo "Complete!"

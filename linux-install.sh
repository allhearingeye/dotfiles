#!/bin/bash

vimplug=$HOME/.vim/autoload/plug.vim
undodir=$HOME/.vim/undodir
terminator_dir=$HOME/.config/terminator

if [[ -f "$vimplug" ]]; then
    echo "Vim-plug exists"
else
    echo "Downloading vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || exit
fi

# Set display for WSL
if [[ $(uname -a | grep [Mm]icrosoft) ]]; then
    display="export DISPLAY=\"\$(/sbin/ip route | awk '/default/ { print \$3 }'):0\""

    if [[ -n "`$SHELL -c 'echo $ZSH_VERSION;'`" ]]; then
        shellrc="$HOME/.zshrc"
    elif [[ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]]; then
        shellrc="$HOME/.bashrc"
    else
        echo ".bashrc and .zshrc not found"
    fi

    if [[ -n $shellrc ]]; then
        case `grep -Fx "$display" "$shellrc" >/dev/null; echo $?` in
            0) ;;
            1)
              echo -e "$display" >> $shellrc
              ;;
            *)
              echo "Something went wrong while set DISPLAY"
            ;;
        esac
    fi
fi

[[ -d $undodir ]] || mkdir -p $undodir
echo "Installing..."
[[ -f "$HOME/.vimrc" ]] && rm $HOME/.vimrc
ln -s $PWD/.vimrc $HOME/.vimrc
vim +"PlugInstall --sync" +qa
[[ -f "$HOME/.tmux.conf" ]] && rm $HOME/.tmux.conf
ln -s $PWD/.tmux.conf $HOME/.tmux.conf

if [[ -n $TMUX ]]; then
    tmux source-file $HOME/.tmux.conf
    read -n1 -p "You need to restart tmux to fix colors in vim. Kill tmux? [y/n]" doit
    case $doit in
      y|Y) tmux kill-server;;
      *  ) echo -e  "\n\nDon't forget to restart tmux manually";;
    esac
fi

[[ -f $terminator_dir/config ]] && rm $terminator_dir/config
[[ -d $terminator_dir ]] || mkdir -p $terminator_dir
ln -s $PWD/terminator/config $terminator_dir/config


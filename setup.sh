# Vim Setup
if [ ! -e ~/.vimrc ] ; then
    echo "Linking vimrc..."
    ln -s $(readlink -f ./vimrc) ~/.vimrc
fi

if [ ! -d ~/.vim/bundle ] ; then
    echo "Installing vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

# Emacs Setup
if [ ! -d ~/.emacs.d ] ; then
    echo "Linking emacs.d..."
    ln -s $(readlink -f ./emacs.d) ~/.emacs.d
fi

# Tmux Setup
if [ ! -e ~/.tmux.conf ] ; then
    echo "Linking TMUX Config..."
    ln -s $(readlink -f ./tmux.conf) ~/.tmux.conf
fi


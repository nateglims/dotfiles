# My Bashrc

# Paths
if [ -d $HOME/bin ]; then
  export PATH=$PATH:$HOME/bin
fi

if [ -d /home/nathan/.pyenv/bin ]; then
	export PATH="/home/nathan/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

#if command -v tmux > /dev/null; then
#    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
#fi

if [ -d /opt/ccl ]; then
    export CCL_DEFAULT_DIRECTORY="/opt/ccl"
fi

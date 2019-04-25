source ~/.bashrc
export PS1="\W \$ "
export PATH=$HOME/.nodebrew/current/bin:$PATH
NODE_PATH=`npm root -g`
export NODE_PATH

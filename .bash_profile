export PS1="\W \$ "
export PATH=$HOME/.nodebrew/current/bin:/opt/homebrew/bin:$PATH
NODE_PATH=`npm root -g`
export NODE_PATH
export TERM=xterm-color
alias ls='ls -G'
alias ll='ls -hl'
export BASH_SILENCE_DEPRECATION_WARNING=1
export KINTONE_BASE_URL=https://zennosuke.cybozu.com
export KINTONE_USERNAME=zenei
export KINTONE_PASSWORD=zenjiro
export REDASH_AUTHORIZATION_KEY=uQh7ziZr1xPJ4fJhXLlXC2IsVD0slsCpS7D64cLn
source ~/.bashrc


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/bin/google-cloud-sdk/completion.bash.inc'; fi
export PATH="/opt/homebrew/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/z000907/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

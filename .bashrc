# alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
# alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
export EDITOR=vi

#
# 出力の後に改行を入れる
#
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'

#
# プロンプトに Git ブランチを表示する
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
#
source ~/.git-prompt.sh
export PS1='\[\e[36m\] \w \[\e[0m\]\[\e[1;32m $(__git_ps1 "(%s)") \[\e[0m\] \n > '

#
# direnv 用
#
eval "$(direnv hook bash)"

#
# Alias 設定
#
alias ll='ls -la'
alias dcup='docker-compose up -d'
alias dcdn='docker-compose down'
alias tree='tree -N'

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/z000907/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

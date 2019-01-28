alias v="nvim"
alias vim="nvim"
alias edit="$EDITOR"
alias zshconf="$EDITOR $ZDOTDIR/.zshrc"
alias vimconf="$EDITOR $DOTCONF/nvim/init.vim"
alias tmuxconf="$EDITOR $DOTCONF/tmux/tmux.conf"
function enc() {
  echo -n $1 | base64 | tr -d '\n' | pbcopy
}
function dec() {
  echo -n $1 | base64 -D | pbcopy
}
alias tmux="tmux -f $DOTCONF/tmux/tmux.conf"

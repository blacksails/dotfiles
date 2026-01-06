alias dotfiles='git --git-dir ~/.files/ --work-tree ~'
if command -v lazygit >/dev/null 2>&1; then
  alias dotfiles-lazy='lazygit --git-dir ~/.files/ --work-tree ~'
fi

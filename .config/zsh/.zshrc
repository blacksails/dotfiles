# Core environment (needed immediately)
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export PATH=/opt/homebrew/bin:$PATH

# Vi mode (set early for key bindings)
bindkey -v

# Zinit setup (minimal bootstrap)
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    command mkdir -p "${ZINIT_HOME%/*}" && command chmod g-rwX "${ZINIT_HOME%/*}"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Zoxide
zinit ice as"command" from"gh-r" \
    atclone"./zoxide init zsh --cmd cd > init.zsh" \
    atpull"%atclone" src"init.zsh"
zinit light ajeetdsouza/zoxide

# go-fly
zinit ice as"command" from"gh-r" pick"fly" \
    atclone"./fly init > init.zsh; ./fly refresh &!" \
    atpull"%atclone" src"init.zsh"
zinit light TheOneWithTheWrench/go-fly

# Local config files (load immediately - exports/aliases needed early)
for conf in $ZDOTDIR/conf.d/*.zsh; do
    source "$conf"
done
for secret in $ZDOTDIR/secrets.d/*.zsh(N); do
    source "$secret"
done

# Autosuggestions
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# fzf-tab
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# OMZ plugins with turbo mode (deferred loading)
zinit wait lucid for \
    OMZP::git \
    OMZP::kubectl

# Load Lunar plugin if available
#zinit ice wait lucid \
#    if"[[ -f ~/go/src/github.com/lunarway/lw-zsh/lw-zsh-core/lw-zsh-core.plugin.zsh ]]" \
#    pick"lw-zsh-core/lw-zsh-core.plugin.zsh"
#zinit ice wait lucid \
#    if"[[ -f ~/go/src/github.com/lunarway/lw-zsh/lw-zsh.plugin.zsh ]]" \
#    pick"lw-zsh.plugin.zsh"
#zinit light ~/go/src/github.com/lunarway/lw-zsh

# Completions (deferred - generated on install/update, cached otherwise)
zinit ice wait lucid as"completion" has"kubectl" id-as"kubectl-comp" \
    atclone"kubectl completion zsh > _kubectl" atpull"%atclone"
zinit snippet /dev/null

zinit ice wait lucid as"completion" has"stern" id-as"stern-comp" \
    atclone"stern --completion zsh > _stern" atpull"%atclone"
zinit snippet /dev/null

zinit ice wait lucid as"completion" has"gh" id-as"gh-comp" \
    atclone"gh completion -s zsh > _gh" atpull"%atclone"
zinit snippet /dev/null

zinit ice wait lucid as"completion" has"sqlc" id-as"sqlc-comp" \
    atclone"sqlc completion zsh > _sqlc" atpull"%atclone"
zinit snippet /dev/null

# Initialize completions (after all completions are set up)
zinit ice wait'1' lucid atinit'autoload -Uz compinit; compinit -C -d "$ZDOTDIR/.zcompdump"'
zinit light zdharma-continuum/null

zinit ice depth=1 wait lucid
zinit light jeffreytse/zsh-vi-mode

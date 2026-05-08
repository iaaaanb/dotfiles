# ~/.bashrc

# Si no es interactivo, salir
[[ $- != *i* ]] && return

# === HISTORIAL ===
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s checkwinsize

# === ALIASES BÁSICOS ===
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# === EZA (reemplaza ls) ===
alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -lah --icons=auto --group-directories-first --git'
alias la='eza -a --icons=auto --group-directories-first'
alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
alias ltt='eza --tree --level=3 --icons=auto --group-directories-first'

# === BAT (reemplaza cat) ===
alias cat='bat --paging=never --style=plain'
alias catf='bat'   # con paging y headers cuando lo querés explícito

# === RIPGREP (reemplaza grep) ===
alias grep='grep --color=auto'   # mantengo grep clásico por si scripts lo usan
# rg ya está disponible directo, no hace falta alias

# === FD (reemplaza find) ===
# fd ya está disponible directo

# === FZF: Ctrl+R, Ctrl+T, Alt+C ===
eval "$(fzf --bash)"

# Config visual de fzf con tu paleta (negro/gris/naranja)
export FZF_DEFAULT_OPTS="
--height 40%
--layout=reverse
--border=rounded
--margin=1
--padding=1
--color=bg+:#1a1a1a,bg:#000000,spinner:#f35638,hl:#f35638
--color=fg:#e6e6e6,header:#f35638,info:#a8a8a8,pointer:#f35638
--color=marker:#f35638,fg+:#ffffff,prompt:#f35638,hl+:#f35638
--color=border:#404040
"

# Comandos default que usa fzf (usar fd en vez de find)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Preview de archivos en Ctrl+T (con bat)
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
# Preview de carpetas en Alt+C (con eza)
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons=auto {}'"

# === ZOXIDE (cd inteligente) ===
eval "$(zoxide init bash --cmd cd)"
# Esto reemplaza tu cd por zoxide. Después de visitar carpetas una vez,
# podés saltar con `cd parte-del-nombre`. Ej: `cd dot` → ~/dotfiles

# === STARSHIP PROMPT ===
eval "$(starship init bash)"

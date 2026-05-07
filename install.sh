#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"
mkdir -p "$CONFIG"

backup_dir="$HOME/.config.backup-$(date +%F-%H%M%S)"

link() {
    local src="$1" dst="$2"
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        mkdir -p "$backup_dir"
        mv "$dst" "$backup_dir/"
        echo "→ backup: $dst"
    fi
    ln -sfn "$src" "$dst"
    echo "→ link:   $dst → $src"
}

link "$DOTFILES/hypr"                   "$CONFIG/hypr"
link "$DOTFILES/kitty"                  "$CONFIG/kitty"
link "$DOTFILES/starship/starship.toml" "$CONFIG/starship.toml"

# Próximos:
# link "$DOTFILES/waybar" "$CONFIG/waybar"
# link "$DOTFILES/swaync" "$CONFIG/swaync"
# link "$DOTFILES/fuzzel" "$CONFIG/fuzzel"

[[ -d "$backup_dir" ]] && echo "Backups en: $backup_dir"
echo "✓ install.sh terminado"

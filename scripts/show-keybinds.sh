#!/usr/bin/env bash
# Lee keybinds.conf, los formatea, los muestra con fuzzel.
# Las líneas vacías y comentarios se usan para agrupar visualmente.

KEYBINDS_FILE="$HOME/.config/hypr/conf.d/keybinds.conf"

[[ ! -f "$KEYBINDS_FILE" ]] && {
    notify-send -u critical "Error" "No encuentro $KEYBINDS_FILE"
    exit 1
}

# Parser: lee bind/binde/bindl/bindel/bindm + extrae mod + key + action
# Salida formateada: "MOD+KEY  →  acción"
parse_binds() {
    local current_section=""
    while IFS= read -r line; do
        # Capturar comentarios tipo "# === SECCIÓN ===" como headers
        if [[ "$line" =~ ^#[[:space:]]*===[[:space:]]*(.+)[[:space:]]*===[[:space:]]*$ ]]; then
            current_section="${BASH_REMATCH[1]}"
            echo ""
            echo "─── ${current_section} ───"
            continue
        fi

        # Capturar binds reales
        if [[ "$line" =~ ^bind(e|l|el|m)?[[:space:]]*=[[:space:]]*([^,]+),[[:space:]]*([^,]+),[[:space:]]*(.+)$ ]]; then
            local mod="${BASH_REMATCH[2]// /}"
            local key="${BASH_REMATCH[3]// /}"
            local action="${BASH_REMATCH[4]}"

            # Reemplazar $mainMod por SUPER
            mod="${mod//\$mainMod/SUPER}"

            # Limpiar espacios extra
            action="$(echo "$action" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

            # Si mod está vacío, mostrar solo la tecla
            local combo
            if [[ -z "$mod" ]]; then
                combo="$key"
            else
                combo="$mod + $key"
            fi

            printf "%-30s  →  %s\n" "$combo" "$action"
        fi
    done < "$KEYBINDS_FILE"
}

# Mostrar con fuzzel en modo dmenu, ancho mayor para que entre todo
parse_binds | fuzzel \
    --dmenu \
    --prompt "❯ keybinds: " \
    --width 80 \
    --lines 25 \
    --no-icons \
    > /dev/null

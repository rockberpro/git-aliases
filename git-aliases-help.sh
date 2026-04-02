#!/bin/bash

# ─── Configuração ─────────────────────────
ALIAS_WIDTH=5     # Largura da coluna de alias
CMD_WIDTH=38      # Largura da coluna de comando
NUM_COLS=1        # Colunas lado a lado (1 ou 2)
COL_GAP="|"       # Espaço entre colunas

# ─── Aliases: "alias|comando completo" ────
ALIASES=(
  "ad|add"
  "ada|add ."
  "adu|add --update"
  "bl|blame"
  "br|branch"
  "brd|branch --delete"
  "brl|branch --list"
  "cfg|config"
  "cfgl|config --list"
  "cln|clean"
  "clf|clean --force"
  "clo|clone"
  "cha|cherry-pick --abort"
  "chc|cherry-pick --continue"
  "chp|cherry-pick"
  "ck|checkout"
  "cm|commit"
  "cma|commit --amend"
  "cmf|commit --fixup"
  "cmm|commit --message"
  "cmn|commit --amend --no-edit"
  "df|diff"
  "dfc|diff --cached"
  "ds|describe"
  "ft|fetch"
  "ftp|fetch --prune"
  "gp|grep"
  "in|init"
  "lg|log"
  "lgh|log HEAD"
  "lgo|log --graph --oneline --decorate --all"
  "lgp|log --patch"
  "mg|merge"
  "mga|merge --abort"
  "mgc|merge --continue"
  "mgs|merge --squash"
  "pl|pull"
  "plh|pull origin HEAD"
  "ps|push"
  "psf|push --force-with-lease"
  "psh|push origin HEAD"
  "pshf|push origin HEAD --force-with-lease"
  "rb|rebase"
  "rba|rebase --abort"
  "rbc|rebase --continue"
  "rbi|rebase --interactive"
  "rs|restore"
  "rsa|restore ."
  "rss|restore --staged"
  "rst|reset"
  "rt|remote"
  "rv|revert"
  "scb|branch --show-current"
  "sh|show --patch"
  "st|status"
  "sts|status --short --branch"
  "sth|stash"
  "stha|stash apply"
  "sthd|stash drop"
  "sthl|stash list"
  "stho|stash pop"
  "sthp|stash push"
  "sths|stash show --patch"
  "sw|switch"
  "swc|switch --create"
  "tg|tag"
)

# ─── Agrupamento por letra inicial ────────
unset GROUPS
declare -A GROUPS
declare -a ORDERED_LETTERS=()

for entry in "${ALIASES[@]}"; do
  alias_name="${entry%%|*}"
  cmd="${entry#*|}"
  letter="${alias_name:0:1}"
  letter="${letter^^}"
  if [[ -z "${GROUPS[$letter]+set}" ]]; then
    ORDERED_LETTERS+=("$letter")
    GROUPS[$letter]=""
  fi
  GROUPS[$letter]+="${alias_name}|${cmd}"$'\n'
done

IFS=$'\n' sorted_letters=($(printf '%s\n' "${ORDERED_LETTERS[@]}" | sort -u))
unset IFS

# ─── Monta linhas de saída (100% ASCII) ───
# Cada linha terá exatamente COL_WIDTH bytes/chars (sem unicode)
# Formato:  "  alias | comando..."
# Cabeçalho: "-- A ---...---"

COL_WIDTH=$(( 2 + ALIAS_WIDTH + 3 + CMD_WIDTH ))  # "  alias | comando"

OUTPUT_LINES=()

for letter in "${sorted_letters[@]}"; do
  # Cabeçalho ASCII: "-- A ---------"
  prefix="-- ${letter} "
  remaining=$(( COL_WIDTH - ${#prefix} ))
  header="${prefix}$(printf -- '-%.0s' $(seq 1 $remaining))"
  OUTPUT_LINES+=("$header")

  while IFS='|' read -r a c; do
    [[ -z "$a" ]] && continue
    # Trunca se necessário
    max_c=$(( CMD_WIDTH ))
    if (( ${#c} > max_c )); then c="${c:0:$(( max_c - 1 ))}~"; fi
    line="$(printf "  %-${ALIAS_WIDTH}s | %-${CMD_WIDTH}s" "$a" "$c")"
    OUTPUT_LINES+=("$line")
  done <<< "${GROUPS[$letter]}"

  OUTPUT_LINES+=("$(printf '%*s' "$COL_WIDTH" '')")  # linha em branco (espaços)
done

# --- Impressao (N colunas) ---
total=${#OUTPUT_LINES[@]}
gap="$COL_GAP"

# Linhas por coluna
chunk=$(( (total + NUM_COLS - 1) / NUM_COLS ))

for (( i = 0; i < chunk; i++ )); do
  row=""
  for (( col = 0; col < NUM_COLS; col++ )); do
    idx=$(( col * chunk + i ))
    cell="${OUTPUT_LINES[$idx]:-}"
    if (( col < NUM_COLS - 1 )); then
      row+="$(printf '%-*s' "$COL_WIDTH" "$cell")${gap}"
    else
      row+="$cell"
    fi
  done
  printf '%s\n' "$row"
done
#!/bin/bash

# --- Configuration ---
ALIAS_WIDTH=5     # Alias column width
CMD_WIDTH=38      # Command column width
NUM_COLS=1        # Number of side-by-side columns (1 or 2)
COL_GAP="|"       # Gap between columns

# --- Aliases: "alias|full command" ---
# Attempt to load aliases from `git config` (global/local).

ALIASES=()
if command -v git >/dev/null 2>&1; then
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    # format: "alias.name command..." — split the first token (key)
    name="${line%% *}"
    cmd="${line#* }"
    # remove 'alias.' prefix from the key
    name="${name#alias.}"
    # add in the format expected by the existing logic
    ALIASES+=("${name}|${cmd}")
  done < <(git config --get-regexp '^alias\.' 2>/dev/null || true)
fi

# Require `git` to list aliases dynamically. If `git` is not present,
# the script exits with an error because listing aliases without git makes no sense.
if ! command -v git >/dev/null 2>&1; then
  printf 'Error: git command not found. This script requires git to list aliases.\n' >&2
  exit 1
fi

# If git exists but no aliases were found, notify and exit.
if (( ${#ALIASES[@]} == 0 )); then
  printf 'No git aliases configured (git config returned no aliases).\n'
  exit 0
fi

# --- Grouping by initial letter ---
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

# --- Build output lines (100% ASCII) ---
# Each line will have exactly COL_WIDTH bytes/chars (no unicode)
# Format:  "  alias | command..."
# Header: "-- A ---...---"

COL_WIDTH=$(( 2 + ALIAS_WIDTH + 3 + CMD_WIDTH ))  # "  alias | comando"

OUTPUT_LINES=()

for letter in "${sorted_letters[@]}"; do
  # ASCII header: "-- A ---------"
  prefix="-- ${letter} "
  remaining=$(( COL_WIDTH - ${#prefix} ))
  header="${prefix}$(printf -- '-%.0s' $(seq 1 $remaining))"
  OUTPUT_LINES+=("$header")

  while IFS='|' read -r a c; do
    [[ -z "$a" ]] && continue
    # Truncate if needed
    max_c=$(( CMD_WIDTH ))
    if (( ${#c} > max_c )); then c="${c:0:$(( max_c - 1 ))}~"; fi
    line="$(printf "  %-${ALIAS_WIDTH}s | %-${CMD_WIDTH}s" "$a" "$c")"
    OUTPUT_LINES+=("$line")
  done <<< "${GROUPS[$letter]}"

  OUTPUT_LINES+=("$(printf '%*s' "$COL_WIDTH" '')")  # blank line (spaces)
done
# --- Printing (N columns) ---
total=${#OUTPUT_LINES[@]}
gap="$COL_GAP"
# Lines per column
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
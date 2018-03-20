#!/bin/bash
# Draw names from hat in random order, for example to decide player order in
# a kyykkä game.

# Init list of players
player=()

# Prompt names
echo "Names: "
while read a; do
  if [[ -z $a ]]; then
    break
  fi
  player+=("$a")
done

# Init list of drawn players
declare -A drawn

while [[ ${#drawn[@]} -lt ${#player[@]} ]]; do

  # Draw any name
  next_player=$(echo "$RANDOM % ${#player[@]}" | bc)

  # Skip if already drawn
  if [[ ${drawn[$next_player]} ]]; then
    continue
  fi

  # Remember the player
  drawn[$next_player]=1

  # Print next player
  echo "${#drawn[@]}. ${player[$next_player]}"

done

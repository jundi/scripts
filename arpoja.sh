#!/bin/bash

# alustus
heittaja=()

# Kysy heittajat
echo "Anna nimiä: "

while read a; do
  if [[ -z $a ]]; then
    break
  fi
  heittaja+=("$a")
done


# Alustetaan muistilappu
declare -A arvotut

# Arvo järkkä
while [[ ${#arvotut[@]} -lt ${#heittaja[@]} ]]; do

  # Nostetaan hatusta
  arpa=$(echo "$RANDOM % ${#heittaja[@]}" | bc)

  # Nostettiinko jo kerran?
  if [[ ${arvotut[$arpa]} ]]; then
    continue
  fi

  # Pistetään muistiin
  arvotut[$arpa]=1

  # Ja kerrotaan tulos
  echo "${#arvotut[@]}. ${heittaja[$arpa]}"

done

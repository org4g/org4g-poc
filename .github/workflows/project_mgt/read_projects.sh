#!/bin/bash

while IFS= read -r line; do
  name=$(echo $line | yq r - name)
  url=$(echo $line | yq r - url)

  # Extract name parts by splitting on "_"
  IFS="_" read -ra name_parts <<< "$name"
  
  # Build the submodule path based on name parts
  submodule_path="d4g/${name_parts[0]}/${name_parts[1]}"

  # Check if the submodule exists; if not, add it
  if [ ! -d "$submodule_path" ]; then
    git submodule add --name $name $url "$submodule_path"
  fi

  
done < "config.yml"

#!/bin/sh

# Read the config file
CONFIG_YAML=config.yml

while IFS= read -r line; do
  season=$(echo $line | yq r - season)
  project=
  name=$(echo $line | yq r - name)
  url=$(echo $line | yq r - url)

  # Extract the repository name from the URL
  repo_name=$(basename $url .git)

  # Build the submodule path
  IFS="_" read -ra name_parts <<< "$name"
  submodule_path="seasons/${name_parts[0]}/${name_parts[1]}"

  # Check if the submodule exists; if not, add it
  if [ ! -d "$submodule_path" ]; then
    git submodule add --name $name $url "$submodule_path"
  fi

  # Extract the repository name from the URL
  repo_name=$(basename $url .git)

  # Request access to the repository
  OWNER=organization
  REPO=$repo_name
  GITHUB_TOKEN=$1
  RESPONSE=$(curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -d '{"permission": "push"}' "https://api.github.com/repos/$OWNER/$REPO/collaborators/D4G")
  echo $RESPONSE
done < "$CONFIG_YAML"

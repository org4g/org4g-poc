#!/bin/bash



while IFS= read -r line; do
  name=$(echo $line | yq r - name)
  url=$(echo $line | yq r - url)

  # Extract name parts by splitting on "_"
  IFS="_" read -ra name_parts <<< "$name"
  
  # Build the submodule path based on name parts
  submodule_path="d4g/${name_parts[0]}/${name_parts[1]}"

  # Extract the repository name from the URL
  repo_name=$(basename $url .git)

  OWNER=organization
  REPO=$repo_name
  GITHUB_TOKEN=${{ secrets.GITHUB_TOKEN }}
  RESPONSE=$(curl -X PUT -H "Authorization: token $GITHUB_TOKEN" \
    -d '{"permission": "push"}' \
    "https://api.github.com/repos/$OWNER/$REPO/collaborators/D4G")

  echo $RESPONSE
done < "config.yml"

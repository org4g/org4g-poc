#!/usr/bin/env bash

# Read the config file
CONFIG_YAML=projects.list

while IFS= read -r line; do
  season=$(echo $line | yq r - season)
  url=$(echo $line | yq r - url)
  branch=$(echo $line | yq r - branch) # Extract the branch

  # Extract the repository name from the URL
  repo_name=$(basename $url .git)

  # Extract the owner and determine if it's GitHub or GitLab
  if [[ $url == *github.com* ]]; then
    owner=$(echo $url | sed 's/https:\/\/github.com\///;s/\/.*//')
    api_base="https://api.github.com"
  elif [[ $url == *gitlab.com* ]]; then
    owner=$(echo $url | sed 's/https:\/\/gitlab.com\///;s/\/.*//')
    api_base="https://gitlab.com/api/v4"
  else
    # Handle other repository hosting platforms here if needed
    echo "Unsupported repository hosting platform."
    continue
  fi

  # Format the season as a two-digit uppercase string (e.g., S01)
  season_name=$(printf "S%02d" $season)

  # Build the submodule path as 'seasonwith2digitsuppercase-repofromurl'
  submodule_path="${season_name}-${repo_name}"

  # Check if the submodule exists; if not, add it
  if [ ! -d "$submodule_path" ]; then
    # Add the submodule with the specified branch
    git submodule add --name $season_name --branch $branch $url "$submodule_path"
  fi

  # Request access to the repository
  REPO=$repo_name
  GITHUB_TOKEN=$1
  RESPONSE=$(curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -d '{"permission": "push"}' "$api_base/repos/$owner/$REPO/collaborators/D4G")
  echo $RESPONSE
done < "$CONFIG_YAML"

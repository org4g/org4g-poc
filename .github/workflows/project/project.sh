#!/bin/bash

# Define the path to the external YAML file
project_list="projects.list"

# Check if the YAML file exists
if [ ! -f "$project_list" ]; then
  echo "Error: projects file not found: $project_list"
  exit 1
fi

# Read the file and extract the projects
projects=$(cat "$project_list")

# Remove comments
projects_cleaned=$(echo "$projects" | grep -Ev '^\s*#')

# Split the content into blocks
readarray -d '[' -t blocks <<< "$projects_cleaned"

# Iterate over the projects
for block in "${blocks[@]}"; do
  # Extract season, url, and branch from each point
  season=$(echo "$block" | grep -oP 'season\s*:\s*\K\d+')
  url=$(echo "$block" | grep -oP 'url\s*:\s*\K[^ ]+')
  branch=$(echo "$block" | grep -oP 'branch\s*:\s*\K[^ ]+')

  # Check if any values are empty before displaying
  if [ -n "$season" ] && [ -n "$url" ]; then
    # If branch is empty, set it to 'main'
    branch=${branch:-'main'}
    # Do something with the extracted values (replace with your actions)
    echo " Processing:"
    echo " season: $season"
    echo " url: $url"
    echo " branch: $branch"
    
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

    # Extract the repository name from the URL
    repo_name=$(basename $url .git)
    # Format the season as a two-digit uppercase string (e.g., S01)
    season_name=$(printf "S%02d" $season)
    # Build the submodule path
    submodule_path="${org}-${season_name}-${repo_name}"

    # Check if the submodule exists; if not, add it
    if [ ! -d "$submodule_path" ]; then
      # Add the submodule with the specified branch
      echo "git submodule add --name $submodule_path --branch $branch $url "$submodule_path""
    fi

    # Request access to the repository
    REPO=$repo_name
    GITHUB_TOKEN=$1
    echo "$GITHUB_TOKEN"
    # RESPONSE=$(curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -d '{"permission": "push"}' "$api_base/repos/$owner/$REPO/collaborators/$org")
    # echo $RESPONSE


  fi
done
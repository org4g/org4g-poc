#!/bin/bash

# Define the path to the external YAML file
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
project_list="$SCRIPT_DIR/projects.list"
org=org4g

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
      repo_owner=$(echo $url | sed 's/https:\/\/github.com\///;s/\/.*//')
      api_base="https://api.github.com"
    elif [[ $url == *gitlab.com* ]]; then
      repo_owner=$(echo $url | sed 's/https:\/\/gitlab.com\///;s/\/.*//')
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
    # Build the submodule name and path
    submodule_name="${org}-${season_name}-${repo_name}"
    submodule_path="${submodule_name}"

    # Check if the submodule exists; if not, add it
    if [ ! -d "$submodule_path" ]; then
      # Add the submodule with the specified branch
      git submodule add --name $submodule_name --branch $branch $url "$submodule_path"
    fi

    

    # Request access to the repository
    OWNER=$repo_owner
    REPO=$repo_name
    GITHUB_TOKEN=$1
    #RESPONSE=$(curl -X PUT -H "Authorization: token $GITHUB_TOKEN" -d '{"permission": "triage"}' "$api_base/repos/$OWNER/$REPO/collaborators/$org")
    
    # Replace 'submodule_owner' and 'submodule_repo' with the owner and repository name of the submodule
    # Replace 'submodule_branch' with the submodule branch you want to request access to
    # Customize the issue title and body as needed
    issue_title="Request Collaboration"
    issue_body="Dear $OWNER,\n\n$org would like to request collaboration on the $REPO repository in the $branch branch. Please consider adding me as a collaborator."
    
    RESPONSE=$(curl -X POST -H "Authorization: token ${{ secrets.GITHUB_TOKEN }}" -d "{\"title\":\"$issue_title\",\"body\":\"$issue_body\"}" "$api_base/repos/$OWNER/$REPO/issues")
    echo $RESPONSE


  fi
done
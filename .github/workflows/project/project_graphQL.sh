#!/bin/bash

# Your GitHub Personal Access Token (should have repo and write:discussion scopes)
GITHUB_TOKEN="YOUR_PERSONAL_ACCESS_TOKEN"

# The repository owner and name
REPO_OWNER="owner"
REPO_NAME="repository"
ORG="organization"
BRANCH="main"

# Define the GraphQL query for requesting collaboration
QUERY_COLLABORATION=$(cat <<EOF
mutation {
  addCollaborator(input: {
    repositoryId: "REPO_ID",  # Replace with the repository ID (you'll need to fetch this using GraphQL)
    collaboratorId: "ORG_ID",  # Replace with the organization ID
    clientMutationId: "add_collaborator"
  }) {
    clientMutationId
  }
}
EOF
)

# Define the GraphQL query for creating an issue
QUERY_ISSUE=$(cat <<EOF
mutation {
  createIssue(input: {
    repositoryId: "REPO_ID",  # Replace with the repository ID (you'll need to fetch this using GraphQL)
    title: "Request Collaboration",
    body: "Dear OWNER,\n\nThe @ORG would like to request collaboration on the REPO repository in the BRANCH branch. Please consider adding me as a collaborator.",
    clientMutationId: "create_issue"
  }) {
    clientMutationId
  }
}
EOF
)

# Fetch the repository ID using the GitHub API
REPO_ID=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"{repository(owner: \"$REPO_OWNER\", name: \"$REPO_NAME\") { id }}\"}" https://api.github.com/graphql | jq -r .data.repository.id)

# Fetch the organization ID using the GitHub API
ORG_ID=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"{organization(login: \"$ORG\") { id }}\"}" https://api.github.com/graphql | jq -r .data.organization.id)

# Request collaboration on the repository
curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"$QUERY_COLLABORATION\"}" https://api.github.com/graphql

# Create an issue for collaboration request
curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"$QUERY_ISSUE\"}" https://api.github.com/graphql

echo "Collaboration request sent successfully."

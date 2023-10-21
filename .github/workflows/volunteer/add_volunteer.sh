#!/bin/bash

# Variables
GITHUB_TOKEN=$1
ORG_NAME=ORG4G
TEAM_NAME=Volunteers
VOLUNTEER_USERNAME=$2

# GraphQL Query to Get User ID
QUERY_GET_USER_ID=$(cat <<EOF
{
  user(login: "$VOLUNTEER_USERNAME") {
    id
  }
}
EOF
)

# GraphQL Query to Get Team ID
QUERY_GET_TEAM_ID=$(cat <<EOF
{
  organization(login: "$ORG_NAME") {
    team(slug: "$TEAM_NAME") {
      id
    }
  }
}
EOF
)

# GraphQL Query to Add Member to Team
QUERY_ADD_MEMBER_TO_TEAM=$(cat <<EOF
mutation {
  addTeamMember(input: { teamId: "TEAM_ID", username: "VOLUNTEER_USERNAME" }) {
    clientMutationId
  }
}
EOF
)

# Get the user ID
USER_ID=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"$QUERY_GET_USER_ID\"}" https://api.github.com/graphql | jq -r .data.user.id)

# Get the team ID
TEAM_ID=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"$QUERY_GET_TEAM_ID\"}" https://api.github.com/graphql | jq -r .data.organization.team.id)

# Add the user to the team
RESPONSE=$(curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d "{\"query\":\"$QUERY_ADD_MEMBER_TO_TEAM\"}" https://api.github.com/graphql)

if [[ "$RESPONSE" =~ "Access not granted" ]]; then
  echo "Access not granted. Exiting..."
  exit 1
fi

echo "Volunteer added to the team successfully."
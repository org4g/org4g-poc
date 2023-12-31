#!/bin/bash

# Variables
GITHUB_TOKEN=$1
ORG_TOKEN=$2
ORG_NAME=org4g
TEAM_NAME=Volunteers
VOLUNTEER_USERNAME=$3
 
# # GraphQL Query to Get User ID
# QUERY_GET_USER_ID=$(cat <<EOF
# { \
#  user(login: \"$VOLUNTEER_USERNAME\") { id } \
# }
# EOF
# )
# echo $QUERY_GET_USER_ID
# # Get the user ID
# USER_ID=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" -X POST -d "{\"query\": \"$QUERY_GET_USER_ID\"}" https://api.github.com/graphql | jq -r .data.user.id)
# #echo $USER_ID


# GraphQL Query to Get Team ID
QUERY_GET_TEAM_ID=$(cat <<EOF
{ \
 organization(login: \"$ORG_NAME\") { \
  team(slug: \"$TEAM_NAME\") { id } \
 } \
}
EOF
)
echo $QUERY_GET_TEAM_ID
# Get the team ID
TEAM_ID=$(curl -s -H "Authorization: Bearer $ORG_TOKEN" -X POST -d "{\"query\": \"$QUERY_GET_TEAM_ID\"}" https://api.github.com/graphql | jq -r .data.organization.team.id)
#echo $TEAM_ID

# # GraphQL Query to Add Member to Team
# QUERY_ADD_MEMBER_TO_TEAM=$(cat <<EOF
# mutation { \
#   addTeamMember(input: { teamId: \"$TEAM_ID\", username: \"$VOLUNTEER_USERNAME\" }) { \
#     clientMutationId \
#   } \
# }
# EOF
# )
# echo $QUERY_ADD_MEMBER_TO_TEAM
# # Add the user to the team
# RESPONSE=$(curl -s -H "Authorization: bearer $ORG_TOKEN" -X POST -d "{\"query\": \"$QUERY_ADD_MEMBER_TO_TEAM\"}" https://api.github.com/graphql)
# echo $RESPONSE

# Define the role (member or maintainer)
ROLE="member"

# Make the REST API request
RESPONSE=$(curl -H "Authorization: Bearer $ORG_TOKEN" -X PUT -d "{\"role\":\"$ROLE\"}" "https://api.github.com/orgs/$ORG_NAME/teams/$TEAM_NAME/memberships/$VOLUNTEER_USERNAME")
echo $RESPONSE

# TODO TEST RESPONSE
echo "Volunteer added to the team successfully."

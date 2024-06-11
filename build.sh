#!/bin/sh

# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Check if the branch is 'production' and run the production build, otherwise run the staging build
if [ "$BRANCH_NAME" = "production" ]; then
    npm run build-production
elif [ "$BRANCH_NAME" = "staging" ]; then
    npm run build-staging
else
    npm run build-dev
fi
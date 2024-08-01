#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Configure git with user information
#git config --global user.email "harshitbansal1116@gmail.com"
#git config --global user.name "hban1116"

# Change to the repository directory
cd /workspace/repo

# Update the deployment YAML file with the new image
sed -i 's#image: dockersamples/examplevotingapp_vote#image: gcr.io/$PROJECT_ID/voting-app:$COMMIT_SHA#g' k8s-specifications/vote-deployment.yaml

# Add the updated file
git add k8s-specifications/vote-deployment.yaml

# Commit the changes
git commit -m "Update voting-app image to gcr.io/$PROJECT_ID/voting-app:$COMMIT_SHA"

# Push the changes
git push origin main

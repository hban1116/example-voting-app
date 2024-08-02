#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Configure git with user information
git config --global user.email "harshitbansal1116@gmail.com"
git config --global user.name "hban1116"

# Change to the repository directory
cd /workspace/repo

# Update the deployment YAML file with the new image
export PROJECT_ID=$(gcloud config get-value project)
export COMMIT_SHA=$(git rev-parse --short HEAD)
cd /workspace/repo
sed -i 's#image: gcr.io/\$PROJECT_ID/voting-app:\$COMMIT_SHA#image: gcr.io/$PROJECT_ID/voting-app:$COMMIT_SHA#g' k8s-specifications/vote-deployment.yaml

# Add the updated file
git add k8s-specifications/vote-deployment.yaml

# Commit the changes
git commit -m "Update voting-app image to gcr.io/$PROJECT_ID/voting-app:$COMMIT_SHA"
echo "Git remote URL:"
git remote -v
git config --list
export PAT=$(gcloud secrets versions access latest --secret="git_vote")
echo "---------------------------------------"
echo $PAT
echo "---------------------------------------"
git remote set-url origin https://hban1116:$PAT@github.com/hban1116/example-voting-app.git
git push 

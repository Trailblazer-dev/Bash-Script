#!/bin/bash

# Check if GitHub CLI (gh) is installed
if ! command -v gh &> /dev/null
then
    echo "GitHub CLI (gh) is not installed. Please install it and try again."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Please install it and try again."
    exit 1
fi

# Check if the repository name is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

REPO_NAME=$1

# Attempt to create a new GitHub repository using the provided name
gh repo create "$REPO_NAME" --public --confirm

# Request the SSH URL from the user
echo "Please provide the SSH URL for the new repository (e.g., git@github.com:username/repo.git):"
read SSH_URL

# Create a new directory with the repository name if it does not exist and navigate into it
if [ ! -d "$REPO_NAME" ]; then
    mkdir "$REPO_NAME"
fi
cd "$REPO_NAME"

# Initialize a new Git repository if not already initialized
if [ ! -d ".git" ]; then
    git init
fi

# Create a README.md file if it doesn't exist
if [ ! -f "README.md" ]; then
    echo "# $REPO_NAME" >> README.md
fi

# Stage the files
git add .

# Commit the files
git commit -m "Initial commit"

# Rename the default branch to main
git branch -M main

# Remove existing remote origin if it exists and add the provided SSH URL as the remote repository
git remote remove origin 2>/dev/null
git remote add origin "$SSH_URL"

# Push the changes to GitHub
git push -u origin main

echo "Repository $REPO_NAME created and pushed to GitHub successfully."

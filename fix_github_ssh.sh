#!/bin/bash
# filepath: fix_github_ssh.sh

# Ensure ~/.ssh exists
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Add GitHub to known_hosts if not already present
if ! ssh-keygen -F github.com > /dev/null; then
    echo "Adding GitHub to known_hosts..."
    ssh-keyscan github.com >> ~/.ssh/known_hosts
fi

# Start ssh-agent if not running
eval "$(ssh-agent -s)"

# Add default SSH key if it exists
if [ -f ~/.ssh/id_rsa ]; then
    ssh-add ~/.ssh/id_rsa
    echo "Added ~/.ssh/id_rsa to ssh-agent."
elif [ -f ~/.ssh/id_ed25519 ]; then
    ssh-add ~/.ssh/id_ed25519
    echo "Added ~/.ssh/id_ed25519 to ssh-agent."
else
    echo "No default SSH key found in ~/.ssh/. Please generate one and add it to your GitHub account."
    exit 1
fi

echo "SSH setup for GitHub is complete."

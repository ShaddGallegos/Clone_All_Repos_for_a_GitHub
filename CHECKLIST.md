# Clone_All_Repos_for_a_GitHub — Checklist

Purpose: Utilities and Ansible playbooks to clone GitHub repositories and Ansible Galaxy collections and generate directory inventories.

Prerequisites
- Python 3
- `ansible-core`, `ansible-galaxy` for collection tasks
- `tree` command for inventory generation (Linux/macOS)

Quick start
```bash
cd Clone_All_Repos_for_a_GitHub
# Clone GitHub repos interactively
ansible-playbook CloneGitHubReposByUser.yml
# Install all collections for a Galaxy namespace
ansible-playbook CloneAnsibleGalaxyCollections.yml
# Generate a directory inventory (HTML/Markdown)
ansible-playbook Create_Table_of_Contents.yml
```

Utilities
- `Delete_Duplicates.py` finds duplicate files and moves them to trash (requires `send2trash`)
- `fix_github_ssh.sh` sets up SSH helper and known_hosts

Notes
- Use `GITHUB_TOKEN` env var for authenticated GitHub API runs to avoid rate limits.
- `defaults/env.yml` is vault-encrypted if secret config is used.

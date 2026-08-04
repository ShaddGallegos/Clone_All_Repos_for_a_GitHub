# Clone_All_Repos_for_a_GitHub

Ansible automation for bulk-cloning GitHub resources and cataloging the results. It can clone every repository owned by a GitHub user, install every collection in an Ansible Galaxy namespace, generate a browsable directory inventory, and clean up duplicate files. Playbooks are interactive (`vars_prompt`) and run entirely against `localhost` — no inventory file is required.

## Contents

| File | Description |
|---|---|
| [CloneGitHubReposByUser.yml](CloneGitHubReposByUser.yml) | Fetches all repos for a GitHub user (paginated) and clones them into a target directory. Supports a GitHub token for higher API rate limits. |
| [CloneAnsibleGalaxyCollections.yml](CloneAnsibleGalaxyCollections.yml) | Queries the Ansible Galaxy API for all collections in a namespace and installs them locally via `ansible-galaxy`. |
| [Create_Table_of_Contents.yml](Create_Table_of_Contents.yml) | Generates an HTML or Markdown directory-tree inventory using the `tree` command (Linux/macOS). |
| [Create_Table_of_Contents.ps1](Create_Table_of_Contents.ps1) | PowerShell equivalent — generates an HTML/Markdown inventory with clickable links using the Windows `tree` command. |
| [Delete_Duplicates.py](Delete_Duplicates.py) | Recursively finds duplicate files (by name, size, MD5 hash) and moves them to the trash. |
| [fix_github_ssh.sh](fix_github_ssh.sh) | Sets up `~/.ssh`, adds GitHub to `known_hosts`, and starts `ssh-agent`. |
| [Clone_All_Repos_for_a_GitHub_inventory.html](Clone_All_Repos_for_a_GitHub_inventory.html) | Pre-generated HTML directory listing of this project. |
| [defaults/](defaults/) | Ansible variable defaults; `env.yml` is vault-encrypted and holds sensitive defaults, `main.yml` controls local env-file precedence. |
| [LICENSE](LICENSE) | MIT License. |

## Usage

**Clone all repos for a GitHub user**
```bash
ansible-playbook CloneGitHubReposByUser.yml
# Prompts: GitHub username, target directory (default: $HOME/Downloads/GIT)
# Optional: export GITHUB_TOKEN=<token> for authenticated API calls
```

**Install all Galaxy collections in a namespace**
```bash
ansible-playbook CloneAnsibleGalaxyCollections.yml
# Prompts: Galaxy username. Requires ansible-galaxy on PATH.
```

**Generate a directory inventory (Linux/macOS)**
```bash
ansible-playbook Create_Table_of_Contents.yml
# Prompts: folder path to scan, output format (HTML or Markdown)
# Requires the `tree` command (installed via dnf if missing)
# Output: /tmp/{base_dir_name}_inventory.{html|md}
```

**Generate a directory inventory (Windows)**
```powershell
.\Create_Table_of_Contents.ps1
# Prompts: folder path, output format (HTML or Markdown)
# Output: {folderPath}\{baseDirName}_inventory.html or .md
```

**Remove duplicate files**
```bash
pip install send2trash
python3 Delete_Duplicates.py
# Interactive prompts confirm deletion of duplicate files
```

**Fix GitHub SSH setup**
```bash
bash fix_github_ssh.sh
```

## Notes

- All playbooks run on `localhost`; no inventory file is needed.
- `defaults/env.yml` is vault-encrypted — use `--ask-vault-pass` or `--vault-password-file` when it's referenced.

#These Scripts ade mainly for Dev Workstations so you can easily pull examples to your local machine from GitHub or Ansible Galaxy and allow you to create a TOC for the folders with links for quick referance.
#All run the same from CLI and will prompt you for what is needed 

ansible-playbook "script"

# Clone_All_Repos_for_a_GitHub

#This playbook clones all the repositories of a GitHub user to a local directory. It prompts the user to enter the GitHub username and uses the GitHub API to fetch the list of repositories. It then parses the repository URLs and clones them to the specified destination directory. Finally, it reports the cloned repositories.

#This playbook requires Ansible 2.9 or later and the uri and git modules. should be covered by the Minimal EE if using AAP. 

 * Fetch the list of repositories: This task uses the uri module to fetch the list of repositories from the GitHub API. The uri module returns the response in JSON format, which is stored in the repos variable.
 * Parse the repository URLs: This task uses the map filter to extract the ssh_url attribute from each repository object in the repos variable. The resulting list of URLs is stored in the repo_urls variable.
 * Ensure destination directory exists: This task uses the file module to create the destination directory if it does not already exist.
 * Clone repositories: This task uses the git module to clone each repository from the repo_urls variable to the specified destination directory.
 * Report cloned repositories: This task uses the debug module to print a message for each cloned repository. The message includes the name of the repository.

# Clone_Collections_for_Ansible_Galaxy
#This playbook clones all the collections of a Ansible Galaxy,  user to a local directory. It prompts the user to enter the Ansible Galaxy,  username and uses the Ansible Galaxy,  API to fetch the list of collections. It then parses the URLs and clones them to the specified destination directory. Finally, it reports the cloned collections. 

# Create_Table_of_Contents
#I hate having to redo or update menus his script will generate a MD or HTML menu you just choose the full path of the directory and it will create the tree menu inside the target folder

#Run with ansible for ".yml" files.
ansible-playbook Create_Table_of_Contents.yml 

#Run with windows or (powershell script)
.\Create_Table_of_Contents.ps1 
 

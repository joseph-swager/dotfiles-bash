# dotfiles-bash
This system development setup with dotfiles works with Debian/Ubuntu/PopOS based systems. However, if your system doesn't support flatpaks from flat hub or snaps please comment these out and isntall the packeges by other means.


Steps to run Ansible Script to install
1. clone to your workspace 
2. `cd dotfiles-bash`
3. `chmod +x dot-bootstrap.sh`
4. `mkdir group_vars`
5. `touch group_vars/local`
6. Add these values at min to the local file
```
dotfiles_user_home: "{{ '~' | expanduser }}" 
dotfiles_home: "{{ dotfiles_user_home }}/.dotfiles"
full_name: your_full_name
git_user: your_git_user_name
git_email: your_email
gpg_sign_key: your_key

```

7. `./dot-bootstrap.sh`

note: you can pass tags as the only arg example:`./dot-bootstrap.sh bash` will only install the bash role and its deps

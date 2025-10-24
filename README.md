# Sway

![screen-1](screenshots/screen-1.png)

![screen-2](screenshots/screen-2.png)

![screen-3](screenshots/screen-3.png)

# Debian installation
1. To install use the latest build of Debian stable (now Debian 13) [link](https://cdimage.debian.org/cdimage/release/current/amd64/iso-cd/);
2. Perform a minimal installation, uncheck all components;

# Prepare 
```shell
sudo apt update
git clone https://github.com/nuxster/my-dotfiles.git
cd my-dotfiles
git switch Sway
```

# Configure
First, you need to initialize a number of variables in the ansible/group_vars/all.yml file with the values that are relevant to you.

# Run installation
The script will install the necessary packages and everything that is required to run Ansible.
```shell
./run.sh
```

# Ranger
```shell
ranger --copy-config=all
vim /home/$USERNAME/.config/ranger/rc.conf

set preview_script ~/.config/ranger/scope.sh
set colorscheme solarized

# To preview images, add the following lines to ranger configuration file
# and install python module 'pillow':
set preview_images true
set preview_images_method kitty

sudo apt install python3-pil

#! Image preview does not work in tmux session yet !

```

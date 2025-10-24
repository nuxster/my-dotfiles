#!/usr/bin/env bash

INSTALL_PKG="apt install --no-install-recommends -y"
UPDATE_PKG="apt update"
UPGRADE_PKG="apt upgrade -y"
UNINSTALL_PKG="apt purge --auto-remove -y"
CLEAN_PKG="apt clean"

MICROCODE="intel-microcode"
#MICROCODE="amd64-microcode"

XORG_GPU_DRIVER="xserver-xorg-video-intel"
#XORG_GPU_DRIVER="xserver-xorg-video-nouveau"
#XORG_GPU_DRIVER="xserver-xorg-video-ati"

X_TERMINAL="kitty"

CMD_SHELL="fish"

FONTS_DIR="~/.fonts"
#FONTS_DIR="/usr/share/fonts/truetype"

SSD="sda"

if [ $USER != "root" ]; then
  echo "You need to have root-user credentials!"
  exit 1
fi

if [ -z "$1" ]; then
    echo "You need to specify username!"
    exit 1
else
  USERNAME=$1
fi

echo "Disable 'APT install recommends' ... "
cat >> /etc/apt/apt.conf<<EOF
APT::Install-Recommends "false";
APT::Install-Suggests "false";
EOF
$UPDATE_PKG
$UPGRADE_PKG

echo "Update to Sid ... "
sed -i "s/^/#/g" /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ sid main non-free non-free-firmware contrib" >> /etc/apt/sources.list
$UPDATE_PKG

echo "Install software ... "
$INSTALL_PKG $MICROCODE \
  linux-headers-amd64 \
  build-essential \
  firmware-linux \
  firmware-linux-free \
  firmware-linux-nonfree \
  firmware-misc-nonfree \
  ca-certificates \
  dkms \
  zstd \
  tmux \
  ranger \
  file \
  w3m \
  w3m-img \
  htop \
  duf \
  sshfs \
  openssl \
  gnupg2 \
  wget \
  curl \
  git \
  grc \
  exfatprogs \
  dosfstools \
  ntfs-3g

$CLEAN_PKG

echo "Uninstall vim and install NeoVim ... "
apt purge --auto-remove -y vim-tiny vim-common
$INSTALL_PKG neovim
update-alternatives --config editor

echo "Configuration sudo for $USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

echo "Configuration GRUB ... "

echo "Backup /etc/default/grub to /etc/default/grub_BK ... "
cp /etc/default/grub /etc/default/grub_BK

echo "Set new GRUB configuration ... "
cat > /etc/default/grub<<EOF
# info -f grub -n 'Simple configuration'
GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=native"
GRUB_CMDLINE_LINUX=""
EOF
update-grub

echo "Install X11 ... "
$INSTALL_PKG $XORG_GPU_DRIVER $X_TERMINAL \
  xorg \
  xserver-xorg-core \
  xserver-xorg-input-all \
  xserver-xorg-video-fbdev

$CLEAN_PKG

echo "Select X-terminal emulator ... "
update-alternatives --config x-terminal-emulator

echo "Install Awesome WM ... "
$INSTALL_PKG \
  dbus-x11 \
  xdg-dbus-proxy \
  at-spi2-core \
  network-manager-gnome \
  network-manager-openvpn-gnome \
  parcellite \
  i3lock \
  lightdm \
  lightdm-gtk-greeter \
  arandr \
  rofi \
  awesome \
  awesome-extra

$CLEAN_PKG

echo "Set NetworkManager managed ... "
sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf

echo "Install software for automount ... "
$INSTALL_PKG \
  udisks2 \
  udiskie \
  gir1.2-gtk-3.0 \
  gir1.2-notify-0.7 \
  libblockdev-crypto2

$CLEAN_PKG

echo "Install software for screenshots ... "
$INSTALL_PKG \
  scrot \
  xclip

$CLEAN_PKG

echo "Install software for bluetooth and sound control ... "
$INSTALL_PKG \
  bluetooth \
  rfkill \
  blueman \
  bluez \
  bluez-tools \
  pulseaudio-module-bluetooth \
  pavucontrol \
  alsa-utils

$CLEAN_PKG

echo "Install additional software ... "
$INSTALL_PKG \
  zathura \
  ristretto \
  tumbler \
  transmission-gtk \
  firefox-esr \
  thunderbird \
  aspell-en \
  aspell-ru \
  hunspell-en-us \
  hunspell-ru \
  gimp \
  pass \
  remmina \
  psensor \
  htop \
  mpv \
  parcellite \
  gnome-disk-utility \
  thunar \
  thunar-volman \
  thunar-archive-plugin \
  thunar-font-manager \
  thunar-gtkhash \
  xarchiver \
  gvfs-fuse \
  gvfs-backends \
  cifs-utils \
  bc \
  gnome-keyring

$CLEAN_PKG

echo "Set timezone (Europe/Moscow) ... "
timedatectl set-timezone Europe/Moscow

echo "Install interface customisation software ... "
$INSTALL_PKG \
  lxappearance \
  compton \
  arc-theme \
  dmz-cursor-theme \
  librsvg2-2 \
  librsvg2-common \
  gtk-update-icon-cache \
  gtk2-engines-murrine \
  gtk2-engines-pixbuf \
  plymouth \
  plymouth-themes

$CLEAN_PKG

echo "Install themes ... "
git clone https://github.com/regolith-linux/midnight-gtk-theme.git /tmp/MN-GTK && \
cp -R /tmp/MN-GTK/usr/share/themes/Midnight-GrayNight/ /usr/share/themes/ && \
rm -rf /tmp/MN-GTK

git clone https://github.com/vinceliuice/Qogir-icon-theme.git /tmp/Q-ICON && \
/tmp/Q-ICON/install.sh && \
rm -rf /tmp/Q-ICON

gtk-update-icon-cache -f -t /usr/share/icons/
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders --update-cache

echo "Install fonts ... "
$INSTALL_PKG \
  fonts-font-awesome \
  fonts-dejavu \
  fonts-dejavu-core \
  fonts-dejavu-extra \
  fonts-firacode \
  fonts-freefont-otf \
  fonts-freefont-ttf \
  fonts-liberation \
  fonts-opensymbol \
  fonts-powerline \
  fonts-roboto \
  fonts-roboto-unhinted \
  fonts-symbola \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-base \
  xfonts-encodings \
  xfonts-scalable \
  xfonts-utils

$CLEAN_PKG

su -c "git clone https://github.com/adobe-fonts/source-code-pro.git /tmp/source-code-pro && \
  mkdir -p $FONTS_DIR/source-code-pro && \
  echo 'Copy source-code-pro fonts ... ' && \
  cp /tmp/source-code-pro/TTF/* $FONTS_DIR/source-code-pro/ && \
  rm -rf /tmp/source-code-pro" -s /usr/bin/sh $USERNAME

su -c "git clone https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts && \
  mkdir -p $FONTS_DIR/nerd-fonts && \
  echo 'Copy nerd fonts ... ' && \
  find /tmp/nerd-fonts/ -iname *.ttf -exec cp "{}" $FONTS_DIR/nerd-fonts/ \; && \
  rm -rf /tmp/nerd-fonts" -s /usr/bin/sh $USERNAME

su -c "fc-cache -fr $FONTS_DIR" -s /usr/bin/sh $USERNAME

echo "Suspend and lock screen configuration ... "
cp /etc/systemd/logind.conf /etc/systemd/logind.conf_BK
cat > /etc/systemd/logind.conf<<EOF
HandlePowerKey=suspend
HandleSuspendKey=suspend
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=suspend
HandleRebootKeyLongPress=poweroff
EOF
systemctl restart systemd-logind

cat > /etc/systemd/system/wakelock@.service<<EOF
[Unit]
Description=Lock the screen
Before=sleep.target suspend.target

[Service]
User=%i
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock -c 000000

[Install]
WantedBy=sleep.target suspend.target
EOF
systemctl enable wakelock@$USERNAME.service && systemctl daemon-reload

cat > /lib/systemd/system-sleep/blank<<EOF
#!/usr/bin/env bash

if [ "$1" == "pre" ]; then
  sleep 2
fi
EOF
chmod +x /lib/systemd/system-sleep/blank

echo "Create shutdown, reboot and suspend user commands ... "
cat > /usr/share/applications/poweroff.desktop<<EOF
[Desktop Entry]
Name=poweroff
Comment=Power off
Exec=sudo poweroff
Icon=system-shutdown
Type=Application
EOF

cat > /usr/share/applications/reboot.desktop<<EOF
[Desktop Entry]
Name=reboot
Comment=Reboot system
Exec=sudo reboot
Icon=system-reboot
Type=Application
EOF

cat > /usr/share/applications/suspend.desktop<<EOF
[Desktop Entry]
Name=suspend
Comment=Suspend system
Exec=systemctl suspend
Icon=system-suspend
Type=Application
EOF

echo "User environment configuration ... "
su -c "rsync -va ./dotfiles/ ~/ && \
  mkdir -p ~/.tmux/plugins/ && \
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm" -s /usr/bin/sh $USERNAME

$INSTALL_PKG $CMD_SHELL
usermod -s /usr/bin/$CMD_SHELL $USERNAME
usermod -a -G sudo,audio,video,plugdev,netdev,bluetooth,pulse $USERNAME

echo "Set $USERNAME autologin ... "
cp -rf ./etc/lightdm/{lightdm.conf,lightdm-gtk-greeter.conf} /etc/lightdm/

echo "Configure plymouth ... "
  git clone https://gitlab.com/oficsu/kreelista.git /tmp/kreelista && \
  cd /tmp/kreelista && \
  make install && \
  plymouth-set-default-theme -R kreelista && \
  cd -

echo "Laptop configuration ... "
$INSTALL_PKG \
  xserver-xorg-input-synaptics \
  brightnessctl \
  brightness-udev \
  tlp \
  pm-utils \
  firmware-iwlwifi

$CLEAN_PKG

echo "Set $SHELL as root shell .. "
usermod -s /usr/bin/$CMD_SHELL root
mkdir -p /root/.config/
cp -R ./dotfiles/.config/fish /root/.config/

echo "Set X11 parameters ... "
cp -rf ./etc/X11/xorg.conf.d /etc/X11/

echo "NetworkManager DNS fix ..."
echo "nameserver 127.0.1.1" >> /etc/resolvconf/resolv.conf.d/head

# For SSD-disk
echo "Prepare system for SSD-disk ..."

systemctl enable fstrim.timer
systemctl start fstrim.timer
systemctl status fstrim.timer

cp /usr/share/systemd/tmp.mount /etc/systemd/system/
systemctl enable tmp.mount
systemctl status tmp.mount

echo "block/$SSD/queue/scheduler = deadline" >> /etc/sysfs.conf
echo deadline > /sys/block/$SSD/queue/scheduler

sed -i "s/issue_discards = 0/issue_discards = 1/g" /etc/lvm/lvm.conf

echo "For SSD"
echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.conf
sysctl -p

echo "!!! You need append to /etc/fstab commit=600 and noatime or relatime !!!"

echo "DONE!"

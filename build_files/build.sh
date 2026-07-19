#!/bin/sh
set -ouex pipefail
LFS_VERSION="13.0"
if [ -d "/ctx/system_files" ];then
cp -avf "/ctx/system_files"/. /
fi
dnf -y install --setopt=install_weak_deps=False \
bash binutils bison busybox coreutils curl dash \
diffutils distrobox findutils firefox fish gawk gcc gcc-c++ \
git glibc-devel gnupg gparted grep gzip ksh leafpad m4 \
make nushell opendoas parted patch perl python3 sed tar \
texinfo util-linux wget xonsh xterm \
xz xz-devel zsh
dnf remove -y \
fcitx5 filelight htop kcharselect kde-connect \
kdebugsettings kfind krfb kwalletmanager kwrite nvtop
groupadd -f wheel
groupadd lfs
useradd -s /bin/bash -g lfs -G wheel -m lfs
passwd -d lfs
echo "lfs ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
echo "permit nopass :wheel" >/etc/doas.conf
chown root:root /etc/doas.conf
chmod 0600 /etc/doas.conf
DESKTOP_DIR="/home/lfs/Desktop"
mkdir -p "$DESKTOP_DIR"
BASE_URL="https://www.linuxfromscratch.org/lfs/downloads/stable-systemd"
wget -P "$DESKTOP_DIR" "$BASE_URL/LFS-BOOK-$LFS_VERSION-NOCHUNKS.html"
wget -P "$DESKTOP_DIR" "$BASE_URL/LFS-BOOK-$LFS_VERSION-SYSD.pdf"
wget -P "$DESKTOP_DIR" "$BASE_URL/LFS-BOOK-$LFS_VERSION.tar.xz"
tar -xf "$DESKTOP_DIR/LFS-BOOK-$LFS_VERSION.tar.xz" -C "$DESKTOP_DIR"
chown -R lfs:lfs /home/lfs
dnf clean all

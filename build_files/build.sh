#!/bin/sh
set -uex -o pipefail
LFS_VERSION="13.1"
if [ -d "/ctx/system_files" ];then
cp -avf "/ctx/system_files"/. /
fi

# Install LFS packages required for building the system 
dnf -y install --setopt=install_weak_deps=False \
bash binutils bison busybox coreutils curl dash \
diffutils distrobox findutils firefox fish gawk gcc gcc-c++ \
git glibc-devel gnupg gparted grep gzip ksh leafpad m4 \
make nushell opendoas parted patch perl python3 sed tar \
texinfo util-linux wget xonsh xterm \
xz xz-devel zsh

# Remove unnecessary desktop packages to keep image size minimal
dnf remove -y \
fcitx5 filelight htop kcharselect kde-connect \
kdebugsettings kfind krfb kwalletmanager kwrite nvtop

# Create groups and users needed for LFS
groupadd -f wheel
groupadd lfs
useradd -s /bin/bash -g lfs -G wheel -m lfs
passwd -d lfs
echo "lfs ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
echo "permit nopass :wheel" >/etc/doas.conf
chown root:root /etc/doas.conf
chmod 0600 /etc/doas.conf

# Download LFS documentation to user's desktop
SKEL_DESKTOP="/etc/skel/Desktop"
BASE_URL="https://www.linuxfromscratch.org/lfs/downloads/stable-systemd"
mkdir -p "$SKEL_DESKTOP"

# Download LFS books in various formats
wget -P "$SKEL_DESKTOP" "$BASE_URL/LFS-BOOK-$LFS_VERSION-NOCHUNKS.html"
wget -P "$SKEL_DESKTOP" "$BASE_URL/LFS-SYSD-BOOK-$LFS_VERSION.pdf"
wget -P "$SKEL_DESKTOP" "$BASE_URL/LFS-BOOK-$LFS_VERSION.tar.xz"

# Extract the tarball to make it available
tar -xf "$SKEL_DESKTOP/LFS-BOOK-$LFS_VERSION.tar.xz" -C "$SKEL_DESKTOP"
rm -f "$SKEL_DESKTOP/LFS-BOOK-$LFS_VERSION.tar.xz"

# Set permissions for LFS user
chown -R lfs:lfs /home/lfs

# Clean up package cache to reduce image size
dnf clean all

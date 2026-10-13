# Linux From Scratch (LFS) ISO Builder

This project builds a bootable ISO image based on Fedora's bootc system that includes all packages and patches required to make a Linux From Scratch installation.

## Base Image Used

The project is configured to use `ghcr.io/blastpkmn/ublue-kinoite:latest` as the base image as requested, which provides a Fedora-based system with universal blue customizations.

## Features

- Includes all packages and patches needed for Linux From Scratch installation
- Sets up LFS user and group with proper permissions
- Downloads LFS documentation (HTML, PDF, and tarball formats)
- Optimized size by removing unnecessary desktop packages
- Built using the Universal Blue bootc template pattern

## Building Instructions

### Prerequisites
- NixOS system (as specified in requirements)
- Nix development environment tools available
- podman (for image building)

### Build Process for Regular Linux Systems
1. Enter development shell:
   ```bash
   nix develop
   ```
2. Build container image:
   ```bash
   just build
   ```
3. Build ISO image:
   ```bash
   just build-iso
   ```

### Build Process for NixOS Systems
Due to NixOS security restrictions, podman requires special configuration:

1. Enable user namespaces in kernel or configure podman storage driver
2. Refer to `NIXOS_BUILD_INSTRUCTIONS.md` for detailed steps
3. Alternatively, use manual podman commands with appropriate privileges

The project is already configured to work correctly with the requested ublue-kinoite base image.
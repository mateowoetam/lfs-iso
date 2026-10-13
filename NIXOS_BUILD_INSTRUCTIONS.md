# Building on NixOS

## Prerequisites for Building on NixOS

Due to NixOS's security model, certain podman configurations are required:

1. Enable user namespaces in kernel (add to `/etc/nixos/configuration.nix`):
   ```
   boot.kernelSysctl = {
     "kernel.unprivileged_userns_clone" = 1;
   };
   ```

2. Or configure podman to not use user namespaces:
   ```
   environment.variables.PODMAN_ROOTLESS_STORAGE_DRIVER = "vfs";
   ```

## Manual Build Commands for NixOS

Instead of using `just build`, you can manually run:

```bash
# Install dependencies if needed
nix-env -iA nixpkgs.podman nixpkgs.just nixpkgs.git

# Build the image directly with podman (after enabling user namespaces)
podman build --pull --no-cache -t lfs-iso-image:latest .

# Or for development shell approach
export PATH="/nix/var/nix/profiles/default/bin:$PATH"
nix develop -c podman build --pull --no-cache -t lfs-iso-image:latest .
```

## Alternative Approach Using Nix

You can also leverage the existing nix infrastructure to build:
```bash
# Build using nix
nix build .#image -L
# or 
nix build github:nixos/nixpkgs/nixpkgs-unstable#podman
```

## For ISO Building

The ISO building workflow requires additional tooling:
- `bootc-image-builder` which can be installed via: `nix-env -iA nixpkgs.bootc-image-builder`
- Proper configuration for S3 (if publishing) or just use artifacts

## Recommendation

For NixOS users, the most reliable approach is to:
1. Enable required kernel parameters
2. Run builds with `sudo` if needed for podman access
3. Or set up a temporary container environment that bypasses user namespace restrictions
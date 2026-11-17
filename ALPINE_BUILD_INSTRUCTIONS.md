# Alpine Linux Build Instructions for lfs-iso

This project is designed to be built in a NixOS environment using the provided Nix infrastructure. However, if you need to build it on Alpine Linux, here are the key challenges and workarounds:

## Issues with Current Approach

The main issues when trying to build this project directly on Alpine:

1. Missing bash (should be installed)
2. Missing `just` command
3. Nix-based system requirements
4. Requires podman to be properly configured

## Recommended Solution: Use Nix

Since this project uses Nix flake for dependencies (as seen in `flake.nix`), the proper way to build it is:

1. Ensure you have Nix installed on Alpine
2. Use nix shell to get all dependencies
3. Run builds through nix development environment

## Alternative: Manual Installation (not recommended)

If you cannot use Nix, and want to proceed with manual setup on Alpine:

```bash
# Install the required packages
apk add bash just podman git coreutils grep findutils

# Ensure your podman is properly configured
# You might need to configure user namespaces - but note this will be harder without proper kernel support
```

However, this approach has significant limitations since:
- The system has Nix-based dependencies that rely on specific build environments
- This project uses the `bootc-image-builder` component (`BIB_IMAGE`) which is complex to run in Alpine
- The shell scripts use bash-specific features

## Why This Is Not Ideal for Alpine

This project was built specifically for:
- A NixOS system with proper podman configuration
- The `bootc-image-builder` component requires Nix package management
- It depends on specific Fedora-based base images that work with bootc tooling

## Recommendation

Instead of trying to build in the current Alpine environment, you should:

1. Use a NixOS machine (the intended platform)
2. Or spin up a proper VM with NixOS inside
3. Or use GitHub Actions for the builds if you're developing this project

The project's README clearly indicates it needs "a NixOS system" to build properly.
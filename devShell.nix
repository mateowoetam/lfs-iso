{
  description = "Development shell for lfs-iso project";
  buildInputs = with nixpkgs; [
    podman
    git
    wget
    tar
    xz
    just
    python3
    gcc
    g++
    make
    binutils
    bison
    flex
    gawk
    coreutils
    diffutils
    findutils
    grep
    gzip
    m4
    patch
    perl
    sed
    texinfo
    dosfstools
    rclone
    cosign
  ];
  shellAliases = {
    nix-develop = "nix shell .#devShell";
  };
}
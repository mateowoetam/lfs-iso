{
  description = "Development shell for lfs-iso project";
  buildInputs = with nixpkgs; [
    podman
    git
    wget
    gnutar
    xz
    just
    python3
    gcc
    glibc.dev
    gnumake
    binutils
    bison
    flex
    gawk
    coreutils
    diffutils
    findutils
    gnugrep
    gzip
    m4
    patch
    perl
    gnused
    texinfo
    dosfstools
    rclone
    cosign
  ];
  shellAliases = {
    nix-develop = "nix shell .#devShell";
  };
}

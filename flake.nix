{
  description = "LFS ISO Project Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
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

          # Enable user namespaces for NixOS podman compatibility
          LD_LIBRARY_PATH = "${pkgs.lib.getLib pkgs.podman}/lib:${pkgs.lib.optionalString (pkgs.lib.versionAtLeast pkgs.lib.version "2.4") "${pkgs.lib.getLib pkgs.glibc}/lib"}";

          # Replace shellAliases with shellHook
          shellHook = ''
            export PATH="/build/bin:$PATH"
            alias nix-develop="nix shell .#devShells.default"
          '';
        };
      };
    };
}

{
  description = "LFS ISO Project Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.inherit = {
      system = "x86_64-linux";
      legacyPackages = true;
    };
  };
  outputs = {
    devShell = let
      pkgs = import inputs.nixpkgs;
    in
      pkgs.mkShell {
        buildInputs = with pkgs; [
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
      };
  };
}
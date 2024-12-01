{ system ? builtins.currentSystem
, pins ? import ./npins
, pkgs ? import pins.nixpkgs { inherit system; }
, hooks ? import pins."pre-commit-hooks.nix"
}:

let
  inherit (pkgs) haskell;

  hsPkgs = pkgs.haskellPackages.extend (haskell.lib.packageSourceOverrides {
    aoc2023 = ./.;
  });

in
hsPkgs.shellFor {
  withHoogle = true;
  packages = ps: with ps; [ aoc2023 ];
  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
    ghc
    cabal-install
    ormolu
    hlint
    haskell-language-server
    pcre
    ghcid
    haskellPackages.cabal-fmt
    haskellPackages.haskell-ci
  ];
}

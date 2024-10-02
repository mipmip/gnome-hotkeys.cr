{
  description = "myhotkeys flake" ;

  inputs.nixpkgs.url = "nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {

      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          myhotkeys = pkgs.callPackage ./package.nix { };
        });

      defaultPackage = forAllSystems (system: self.packages.${system}.myhotkeys);

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              crystal
              shards
              wrapGAppsHook4
            ];
          };
        });
    };
}


#{
#  description = "Nix development dependencies for crystal and gtk";
#
#  inputs = {
#    nixpkgs.url = github:nixos/nixpkgs/nixos-24.05;
#    flake-utils.url = github:numtide/flake-utils;
#  };
#
#  outputs = inputs:
#    let
#      utils = inputs.flake-utils.lib;
#    in
#    utils.eachSystem
#      [
#        "x86_64-linux"
#      ]
#      (system:
#        let
#          nixpkgs = import inputs.nixpkgs {
#            inherit system;
#          };
#
#        in
#        {
#
#          devShells.default = nixpkgs.pkgs.mkShell {
#            buildInputs = with nixpkgs.pkgs; [
#              crystal
#              shards
#              wrapGAppsHook4
#            #              blueprint-compiler
#            #              pcre2
#            #              gtk4
#            #              glib
#            #              gobject-introspection
#            #              libadwaita
#            #              libffi
#            #              desktop-file-utils
#            #              cairo
#            #              gdk-pixbuf
#            #              graphene
#            #              gtksourceview5
#            #              libxml2
#            #              meson
#            #              ninja
#            #              pango
#            #              pkg-config
#            #              cmake
#            ];
#
#            nativeBuildInputs = with nixpkgs.pkgs; [
#              crystal
#              shards
#            #              wrapGAppsHook4
#            #              blueprint-compiler
#            #              pcre2
#            #              gtk4
#            #              glib
#            #              gobject-introspection
#            #              libadwaita
#            #              libffi
#            #              desktop-file-utils
#            #              cairo
#            #              gdk-pixbuf
#            #              graphene
#            #              gtksourceview5
#            #              libxml2
#            #              meson
#            #              ninja
#            #              pango
#            #              pkg-config
#            #              cmake
#            ];
#          };
#        });
#}
#

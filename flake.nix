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
              gi-crystal
              libadwaita
              crystal
              gobject-introspection
              shards
              wrapGAppsHook4
            ];
          };
        });
    };
}

{
 description = "sebnyberg's Neovim flake";

 inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs";
   flake-utils.url = "github:numtide/flake-utils";
 };

 outputs = { self, nixpkgs, flake-utils }:
  let

    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
    supportedSystems = [ "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system;  });

  in {
    packages = forAllSystems (system:
      let
        pkgs = nixpkgsFor.${system};
      in
        {
          default = pkgs.writeShellScriptBin "my-script" ''
            #!${pkgs.bash}/bin/bash
            echo "Hello, world!"
          '';
        }
    );
    apps = forAllSystems (system:
      {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/my-script";
        };
      }
    );
  };
}

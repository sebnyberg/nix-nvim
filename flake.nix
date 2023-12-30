{ config, lib, pkgs, ... }:

{
 description = "sebnyberg's Neovim flake";

 inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs";
   flake-utils.url = "github:numtide/flake-utils";
 };

 outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.my-script = pkgs.writeShellScriptBin "my-script" ''
        #!${pkgs.bash}/bin/bash
        echo "Hello, world!"
      '';
    }
  );
}

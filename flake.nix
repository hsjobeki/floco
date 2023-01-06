# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

{

# ---------------------------------------------------------------------------- #

  description = "Yet another Nix+Node.js framework";


# ---------------------------------------------------------------------------- #

  outputs = { nixpkgs, ... } @ inputs: let

# ---------------------------------------------------------------------------- #

    supportedSystems = [
      "x86_64-linux"  "aarch64-linux"  "i686-linux" 
      "x86_64-darwin" "aarch64-darwin"
    ];

    eachSupportedSystemMap = f: builtins.foldl' ( acc: system: acc // {
      ${system} = f system;
    } ) {} supportedSystems;


# ---------------------------------------------------------------------------- #

    overlays.default = overlays.floco;
    overlays.floco = final: prev: {
      lib = import ./lib { inherit (prev) lib; };
      inherit (import ./setup {
        inherit (final) system bash coreutils findutils jq gnused;
        nodejs = final.nodejs-slim-14_x;
      }) floco-utils;
      treeFor = import ./pkgs/treeFor {
        nixpkgs = throw "floco: Nixpkgs should not be referenced from flake";
        inherit (final) system lib;
        pkgsFor = final;
      };
    };


# ---------------------------------------------------------------------------- #

    nixosModules = {
      floco = { config, pkgs, ... }: {
        imports = [./modules/top];
        config._module.specialArgs.lib = import ./lib {
          inherit (nixpkgs) lib;
        };
        config._module.args.pkgs = pkgs.extend overlays.default;
      };
    };


# ---------------------------------------------------------------------------- #

  in {  # Begin `outputs'

    lib = import ./lib { inherit (nixpkgs) lib; };

    inherit overlays nixosModules;

    packages = eachSupportedSystemMap ( system: let
      pkgsFor = nixpkgs.legacyPackages.${system}.extend overlays.default;
    in {
      inherit (pkgsFor)
        floco-utils
        treeFor
      ;
    } );

# ---------------------------------------------------------------------------- #

  };  # End `outputs'


# ---------------------------------------------------------------------------- #

}


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #

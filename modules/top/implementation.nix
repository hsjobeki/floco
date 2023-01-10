# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

{ lib, pkgs, ... }: let

  nt = lib.types;

in {

# ---------------------------------------------------------------------------- #

  options.floco = lib.mkOption {
    type = nt.submoduleWith {
      shorthandOnlyDefinesConfig = false;
      modules = [
        {
          imports = [
            ../pdefs/implementation.nix
            ../packages/implementation.nix
          ];
          config._module.args.pkgs = lib.mkDefault pkgs;
        }
      ];
    };
  };


# ---------------------------------------------------------------------------- #

}


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #
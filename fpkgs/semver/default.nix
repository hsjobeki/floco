# ============================================================================ #
#
# Package shim exposing installable targets from `floco` modules.
#
# ---------------------------------------------------------------------------- #

{ nixpkgs ? ( import ../../inputs ).nixpkgs.flake
, lib     ? import ../../lib { inherit (nixpkgs) lib; }
, system  ? builtins.currentSystem
, pkgsFor ? nixpkgs.legacyPackages.${system}
, fcfg    ? {
    imports = [../../modules/top];
    config._module.args.pkgs = pkgsFor;
  }
}: let

# ---------------------------------------------------------------------------- #

  fmod = lib.evalModules { modules = [fcfg ./floco.nix]; };

# ---------------------------------------------------------------------------- #

in fmod.config.flocoPackages.packages.semver."7.3.8".global


# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #

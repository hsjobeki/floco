# ============================================================================ #
#
#
#
# ---------------------------------------------------------------------------- #

{ lib, config, pkgs ? config._module.args.pkgs, ... }:
  ( import ../../lib/addPdefs.nix { inherit lib; } ) ./pdefs.nix

# ---------------------------------------------------------------------------- #
#
#
#
# ============================================================================ #

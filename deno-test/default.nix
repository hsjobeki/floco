let
  pkgs = import <nixpkgs> {inherit (builtins) currentSystem;};
in {
  deno = pkgs.stdenv.mkDerivation {
    name = "test";
    version = "1.0.0";
    src = ./.;
    buildInputs = [pkgs.deno];
    installPhase = ''
      export HOME=./home
      ls -la .
      deno run main.ts --allow-read > $out
    '';
    # buildPhase = ''
    #   echo installing shit
    # '';
  };
}

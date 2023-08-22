{
  lib,
}: 
let
  /**
    # Arguments:

    - nmDir: A derivation containing $out/node_modules  
    - rsync: [Optional] The rsync executable to be used. default: pkgs.rsync
    
    # Returns 

    string containing the shellHook that can be passed to e.g. pkgs.mkShell
  */
  rsyncShellHook = {
    nmDir,
    rsync,
  }: ''
    ID=${nmDir}
    currID=$(cat .floco/.node_modules_id 2> /dev/null)

    mkdir -p .floco
    if [[ "$ID" != "$currID" || ! -d "node_modules"  ]];
    then
      ${rsync}/bin/rsync -a --chmod=ug+w  --delete ${nmDir}/node_modules/ ./node_modules/
      echo -n $ID > .floco/.node_modules_id
      echo "floco ok: node_modules updated"
    fi

    export PATH="$PATH:$(realpath ./node_modules)/.bin"
  '';
in
{
  inherit rsyncShellHook;
}

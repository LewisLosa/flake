{ pkgs-unstable ? import <nixpkgs> {} }:

let
  pkgs = pkgs-unstable;
  lib = pkgs.lib;

  myPackages = [
    pkgs.bun
    pkgs.nodejs
    pkgs.prisma-engines
    pkgs.prisma
  ];

  # Convert list to grid
  formatToGrid = { items, perLine ? 10, sep ? ", " }:
    let
      names = map (item: item.pname or item.name) items;
      len = builtins.length names;
      numLines = (len + perLine - 1) / perLine;

      # split list into chunks
      makeLine = i: lib.concatStringsSep sep (lib.sublist (i * perLine) perLine names);
    in
    lib.concatStringsSep "\n" (builtins.genList makeLine numLines);

  packageDisplay = formatToGrid {
    items = myPackages;
    perLine = 10;
  };

in
pkgs.mkShell {
  buildInputs = myPackages;

  shellHook = ''
    # Environment Variables
    export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
    export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
    export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
    export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
    export PRISMA_FMT_BINARY="${pkgs.prisma-engines}/bin/prisma-fmt"
    export PATH="$HOME/.bun/bin:$PATH"

    # greetings
    cowsay "hi hacker cat, $(whoami)"
    echo "welcome to hacker cats club" | lolcat
    echo -e "Injected packages:\n${packageDisplay}\n"
    exec zsh
  '';
}

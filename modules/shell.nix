{pkgs-unstable ? import <nixpkgs> {}}: let
  packages = [
    "bun"
    "nodejs"
    "prisma-engines"
    "prisma"
    "openssl"
    "git"
    "curl"
    "wget"
    "jq"
    "ripgrep"
    "fd"
    "fzf"
  ];

  echoPackages =
    builtins.concatStringsSep "\n"
    (map (
      i:
        "echo \"" + builtins.concatStringsSep ", " (builtins.take 10 (builtins.drop (i * 10) packages)) + "\""
    ) (builtins.genList (i: i) ((builtins.length packages + 9) / 10)));
in
  pkgs-unstable.mkShell {
    buildInputs = [
      pkgs-unstable.bun
      pkgs-unstable.nodejs
      pkgs-unstable.prisma-engines
      pkgs-unstable.prisma
    ];

    shellHook = ''
      export PKG_CONFIG_PATH="${pkgs-unstable.openssl.dev}/lib/pkgconfig"
      export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs-unstable.prisma-engines}/bin/schema-engine"
      export PRISMA_QUERY_ENGINE_BINARY="${pkgs-unstable.prisma-engines}/bin/query-engine"
      export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs-unstable.prisma-engines}/lib/libquery_engine.node"
      export PRISMA_FMT_BINARY="${pkgs-unstable.prisma-engines}/bin/prisma-fmt"
      export PATH="/home/eyups/.bun/bin:$PATH"

      cowsay "hi hacker, $(whoami)"
      echo "Welcome to the shell!"
      echo "Injected packages:"
      ${echoPackages}
    '';
  }

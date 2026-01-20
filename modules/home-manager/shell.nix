{ pkgs-unstable ? import <nixpkgs> {} }:
pkgs-unstable.mkShell {
  buildInputs = [
    pkgs-unstable.prisma-engines
    pkgs-unstable.prisma
  ];

  shellHook = ''
    export PKG_CONFIG_PATH="${pkgs-unstable.openssl.dev}/lib/pkgconfig"
    export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs-unstable.prisma-engines}/bin/schema-engine"
    export PRISMA_QUERY_ENGINE_BINARY="${pkgs-unstable.prisma-engines}/bin/query-engine"
    export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs-unstable.prisma-engines}/lib/libquery_engine.node"
    export PRISMA_FMT_BINARY="${pkgs-unstable.prisma-engines}/bin/prisma-fmt"
  '';
}

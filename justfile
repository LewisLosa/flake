default:
    just --list

deploy machine='' ip='':
    @if [ -z "{{ machine }}" ] && [ -z "{{ ip }}" ]; then \
      nixos-rebuild switch --sudo --flake .; \
    elif [ -z "{{ ip }}" ]; then \
      nixos-rebuild switch --sudo --flake ".#{{ machine }}"; \
    else \
      nixos-rebuild switch --no-reexec --sudo \
        --flake ".#{{ machine }}" \
        --target-host "eyups@{{ ip }}" \
        --build-host "eyups@{{ ip }}"; \
    fi

dev:
    nix develop ~/git/sengozhome/flake/

connect-isochan:
    kitten ssh nixos@isochan

format:
    nix fmt .

lint:
    statix check .

rebuild:
    nixos-rebuild switch --flake .

sops-edit editor='':
    @if [ "{{ editor }}" = "code" ]; then \
      SOPS_EDITOR="code --wait --new-window --disable-workspace-trust --disable-extensions --disable-telemetry" \
      sops secrets/secrets.yaml; \
    else \
      sops secrets/secrets.yaml; \
    fi


sops-rotate:
    for file in secrets/*; do sops --rotate --in-place "$file"; done

sops-update:
    for file in secrets/*; do sops updatekeys "$file"; done

update:
    nix flake update

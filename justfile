default:
    just --list

deploy machine='' ip='':
    @if [ -z "{{ machine }}" ] && [ -z "{{ ip }}" ]; then \
      nixos-rebuild switch --sudo --flake .; \
    elif [ -z "{{ ip }}" ]; then \
      nixos-rebuild switch --sudo --flake ".#{{ machine }}"; \
    else \
      nixos-rebuild switch --fast --sudo \
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

update:
    nix flake update

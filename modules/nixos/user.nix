{
  config,
  vars,
  pkgs,
  ...
}: {
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/nix/secret/initrd/initrd_age_key"];
    secrets = {
      "users/eyups/password" = {
        neededForUsers = true;
      };
      "users/eyups/ssh-config" = {
        owner = vars.username;
        path = "/home/${vars.username}/.ssh/config";
        mode = "0600";
      };
    };

    # inspo: https://github.com/Mic92/sops-nix/issues/427
    gnupg.sshKeyPaths = [];
  };

  users.mutableUsers = false;
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      vars.sshPublicKey
    ];
    shell = pkgs.zsh;
    useDefaultShell = true;
    ignoreShellProgramCheck = true;
    hashedPasswordFile = config.sops.secrets."users/eyups/password".path;
  };

  security.sudo.wheelNeedsPassword = false;
}

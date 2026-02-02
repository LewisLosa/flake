{
  config,
  vars,
  pkgs,
  ...
}:
{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/nix/secret/initrd/ssh_host_ed25519_key" ];
    secrets."users/eyups/password".neededForUsers = true;
    secrets."users/eyups/password" = { };
    # inspo: https://github.com/Mic92/sops-nix/issues/427
    gnupg.sshKeyPaths = [ ];
  };

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

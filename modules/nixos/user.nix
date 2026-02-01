{
  vars,
  pkgs,
  ...
}: {
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
  };

  security.sudo.wheelNeedsPassword = false;
}

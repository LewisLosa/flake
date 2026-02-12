_: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
    };
    port = 50768;
    openFirewall = true;
  };
  services.endlessh = {
    enable = true;
    port = 22;
    openFirewall = true;
  };
  services.fail2ban.enable = true;
}

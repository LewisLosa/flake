_: {
  # Server-specific base configuration
  # This can be expanded with server-specific optimizations
  networking.firewall.allowPing = true;

  # Servers usually don't need NetworkManager if they have static IPs or simple DHCP,
  # but keeping it for now as it's in base.nix.
  # However, we can disable some desktop-oriented defaults if they were here.
}

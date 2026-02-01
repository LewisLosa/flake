{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    efibootmgr
    git
    gptfdisk
    parted
    nano
    speedtest-cli
    curl
    dig
    wget
    openssl
    kopia
    jq
    qrencode
    tree
    statix
    imagemagick
    net-tools
    ssh-to-age
  ];
}

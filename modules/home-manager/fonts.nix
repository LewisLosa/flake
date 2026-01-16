{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      inter
      fira-code
      maple-mono.NF
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      lato
      open-sans
      roboto
      ubuntu-classic
      fira-code
      fira-code-symbols
    ];
  };
}

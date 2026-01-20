{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  makeWrapper,
  openssl,
  systemd,
  polkit,
  qt5,
  libGL,
  libxkbcommon,
  fontconfig,
  freetype,
  dbus,
  glib,
  zlib,
  xorg,
}:

stdenv.mkDerivation rec {
  pname = "windscribe";
  version = "2.20.3";

  src = fetchurl {
    url = "https://github.com/Windscribe/Desktop-App/releases/download/v2.20.3/windscribe_2.20.3_guinea_pig_amd64.pkg.tar.zst";
    sha256 = "a04dadeef034827256d85b1f5b7dcd6a56b38476f66d9a62196244cceb2b0357";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = [
    openssl
    systemd
    polkit
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    libGL
    libxkbcommon
    fontconfig
    freetype
    dbus
    glib
    zlib
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libxcb
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    # create application directory
    mkdir -p $out/opt/windscribe
    cp -r opt/windscribe/* $out/opt/windscribe/

    # symlink binary files to /bin
    mkdir -p $out/bin
    ln -s $out/opt/windscribe/windscribe-cli $out/bin/windscribe-cli
    ln -s $out/opt/windscribe/Windscribe $out/bin/windscribe

    # copy desktop files
    mkdir -p $out/share/applications
    cp usr/share/applications/windscribe.desktop $out/share/applications/
    # map desktop paths
    substituteInPlace $out/share/applications/windscribe.desktop \
      --replace "/opt/windscribe/Windscribe" "$out/bin/windscribe" \
      --replace "/opt/windscribe" "$out/opt/windscribe"

    # icons
    mkdir -p $out/share/icons
    cp -r usr/share/icons/hicolor $out/share/icons/

    # license
    mkdir -p $out/share/licenses/windscribe
    cp usr/share/licenses/windscribe/LICENSE $out/share/licenses/windscribe/

    # copy systemd service
    mkdir -p $out/lib/systemd/system
    cp usr/lib/systemd/system/windscribe-helper.service $out/lib/systemd/system/
    # map systemd paths
    substituteInPlace $out/lib/systemd/system/windscribe-helper.service \
      --replace "/opt/windscribe" "$out/opt/windscribe"

    # copy policy file
    mkdir -p $out/share/polkit-1/actions
    cp usr/polkit-1/actions/com.windscribe.authhelper.policy $out/share/polkit-1/actions/
    # map policy paths
    substituteInPlace $out/share/polkit-1/actions/com.windscribe.authhelper.policy \
      --replace "/opt/windscribe" "$out/opt/windscribe"

    # create autostart directory
    mkdir -p $out/etc/windscribe/autostart
    cp etc/windscribe/autostart/windscribe.desktop $out/etc/windscribe/autostart/
    substituteInPlace $out/etc/windscribe/autostart/windscribe.desktop \
      --replace "/opt/windscribe/Windscribe" "$out/bin/windscribe"

    # set permissions for runtime files
    chmod +x $out/opt/windscribe/scripts/*
    chmod +x $out/opt/windscribe/helper
    chmod +x $out/opt/windscribe/windscribe-authhelper
    chmod +x $out/opt/windscribe/windscribe-cli
    chmod +x $out/opt/windscribe/windscribectrld
    chmod +x $out/opt/windscribe/windscribeopenvpn
    chmod +x $out/opt/windscribe/windscribewireguard
    chmod +x $out/opt/windscribe/windscribewstunnel
    chmod +x $out/opt/windscribe/Windscribe

    runHook postInstall
  '';

  # for qt apps
  postFixup = ''
    wrapProgram $out/opt/windscribe/Windscribe \
      --prefix LD_LIBRARY_PATH : "$out/opt/windscribe/lib:${lib.makeLibraryPath buildInputs}" \
      --prefix QT_PLUGIN_PATH : "${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}"
  '';

  meta = with lib; {
    description = "Windscribe VPN client";
    homepage = "https://windscribe.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ "LewisLosa" ];
    mainProgram = "windscribe";
  };
}

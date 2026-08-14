{ pkgs }:

let
  wpilib = pkgs.stdenv.mkDerivation {
  pname = "wpilib-installer";
  version = "2026.2.1";

  src = pkgs.fetchurl {
    url = "https://packages.wpilib.workers.dev/installer/v2026.2.1/Linux/WPILib_Linux-2026.2.1.tar.gz";
    hash = "sha256-w2WRvgtdG3UzVlQ+Dmcq+dkTNfsmtf/LoxzwWvgpxlY=";
  };

  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    mkdir -p "$out"
    cp -r . "$out/"
  '';

  meta = {
    description = "WPILib 2026.2.1 installer";
    homepage = "https://wpilib.org";
    license = pkgs.lib.licenses.bsd3;
    platforms = [ "x86_64-linux" ];
  };
}; in pkgs.buildFHSEnv {
  name = "wpilib-installer";

  targetPkgs = pkgs: with pkgs; [
    libz
    icu
    fontconfig
    glib
    libx11
    libice
    libsm
    openssl
  ];

  runScript = "${wpilib}/WPILibInstaller";
}

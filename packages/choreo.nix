{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "choreo";
  version = "2026.0.3";

  src = pkgs.fetchurl {
    url = "https://github.com/SleipnirGroup/Choreo/releases/download/v2026.0.3/Choreo-v2026.0.3-Linux-x86_64-standalone.zip";
    hash = "sha256-5w1CHQZ+0/rq6uStU3q36C6rzpg1TmlIILYSGQqx3ks=";
  };

  nativeBuildInputs = with pkgs; [
    unzip
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    gtk3
    webkitgtk_4_1
    libsoup_3
  ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    runHook preUnpack

    mkdir -p source
    ${pkgs.unzip}/bin/unzip "$src" -d source

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    mkdir -p "$out/share/icons/hicolor/128x128/apps"
    mkdir -p "$out/share/applications"

    cp -r source/* "$out/"

    chmod +x "$out/choreo"
    chmod +x "$out/choreo-cli"

    ln -s "$out/choreo" "$out/bin/choreo"

    cat > "$out/share/applications/choreo.desktop" <<EOF
[Desktop Entry]
Name=Choreo
Comment=A time-optimal drivetrain trajectory planner for the FIRST Robotics Competition.
Exec=$out/bin/choreo
Type=Application
Icon=choreo
Categories=Robotics;
Terminal=false
EOF

    runHook postInstall
  '';

  meta = {
    description = "A time-optimal drivetrain trajectory planner for the FIRST Robotics Competition.";
    homepage = "https://choreo.autos";
    license = pkgs.lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}

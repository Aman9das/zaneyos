{
  lib,
  hyprland,
  hyprlandPlugins,
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "hyprscroller";
  inherit (hyprland) version;

  src = pkgs.fetchFromGitHub {
    owner = "dawsers";
    repo = "hyprscroller";
    rev = "5c01aac850c21451a5697a6fd7959424b247fe6a";
    sha256 = "sha256-gd0LyHbznXzX/Jgq8ra5oux7FuamCRyo8IzckTb70Eg=";
  };

  nativeBuildInputs = [
    pkgs.cmake
    pkgs.pkg-config
    hyprland
  ];
  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  buildPhase = ''
    make all
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp ./hyprscroller.so $out/lib/libhyprscroller.so
  '';

  meta = with lib; {
    homepage = "https://github.com/dawsers/hyprscroller";
    description = "Hyprland layout plugin providing a scrolling layout like PaperWM";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}

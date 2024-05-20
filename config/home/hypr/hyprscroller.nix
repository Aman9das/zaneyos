{
  lib,
  hyprland,
  # hyprlandPlugins,
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "hyprscroller";
  inherit (hyprland) version;

  src = pkgs.fetchFromGitHub {
    owner = "dawsers";
    repo = "hyprscroller";
    rev = "cdea7ef0065e310dd50cf0be461d99ebe4f1fc11";
    sha256 = "sha256-e4kPx+7fIbyalULlFkAqAPVx9UsqcCX6bYuwYkis5Js=";
  };

  nativeBuildInputs = [
    pkgs.cmake
    pkgs.pkg-config
    hyprland
  ];
  buildInputs = [hyprland] ++ hyprland.buildInputs;

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

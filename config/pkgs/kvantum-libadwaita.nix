{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "kvlibadwaita";
  version = "87c1ef9f44ec48855fd09ddab041007277e30e37";

  src = fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = version;
    hash = "sha256-xBl6zmpqTAH5MIT5iNAdW6kdOcB5MY0Dtrb95hdYpwA=";
};

  installPhase = ''
    mkdir -p $out/share/Kvantum
    cp -r src/KvLibadwaita $out/share/Kvantum
  '';

  meta = with lib; {
    description = "Libadwaita style theme for Kvantum. Based on Colloid-kde.";
    homepage = "https://github.com/GabePoel/KvLibadwaita";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.all;
  };
}

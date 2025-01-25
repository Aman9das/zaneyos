{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  inputs,
  host,
  ...
}:

{
  home.packages = [
    (pkgs.sioyek.overrideAttrs (previousAttrs: {
      version = "2.0.0-unstable-2025-01-23";

      src = pkgs.fetchFromGitHub {
        owner = "ahrm";
        repo = "sioyek";
        rev = "af533f690ff50fdb27f0c83397624202ea10e850";
        hash = "sha256-CiRaiW/rhwaCh16TWTw9ceZA0VQf0THKEnp+xTTq0YU=";
      };
    }))

    # (pkgs.papirus-icon-theme.overrideAttrs (previousAttrs: {
    #   version = "20250124";
    #
    #   src = pkgs.fetchFromGitHub {
    #     owner = "PapirusDevelopmentTeam";
    #     repo = "papirus-icon-theme";
    #     rev = "985f829a6297c7da2366405286bd3a6db574943f";
    #     hash = "sha256-uqiEtjdYNVDu5YGbIWHHy9g0MVxgsdUP9d8/Za5YJUU=";
    #   };
    # }))

  ];
}

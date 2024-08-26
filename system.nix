{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  username,
  hostname,
  host,
  ...
}:
let
  inherit (import ./hosts/${host}/options.nix)
    theLocale
    theTimezone
    gitUsername
    theShell
    wallpaperDir
    wallpaperGit
    theLCVariables
    theKBDLayout
    flakeDir
    theme
    ;
in
{
  imports = [
    ./hosts/${host}/hardware.nix
    ./config/system
    ./users/users.nix
  ];

  # Enable networking
  networking = {
    hostName = "${hostname}"; # Define your hostname
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ]; # for kdeconnect
    firewall.allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ]; # for kdeconnect
  };

  # Set your time zone
  time.timeZone = "${theTimezone}";

  # Select internationalisation properties
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };

  console.keyMap = "${theKBDLayout}";

  # Define a user account.
  users = {
    mutableUsers = true;
  };

  environment.variables = {
    FLAKE = "${flakeDir}";
    ZANEYOS_VERSION = "1.0";
    POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

    NIX_LD = "/run/current-system/sw/share/nix-ld/lib/ld.so";
    NIX_LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";

    NIXOS_OZONE_WL = "1";
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "24.05";
}

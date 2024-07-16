{
  pkgs,
  config,
  lib,
  ...
}:
{
  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "32/48000";
            pulse.max.req = "32/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "32/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "32/48000";
        resample.quality = 1;
      };
    };
  };
  hardware.pulseaudio.enable = false;

  powerManagement.enable = true;
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.upower.enable = true;

  programs.nix-ld.enable = true;

  security.rtkit.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr ];
  };

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=suspend
  '';
}

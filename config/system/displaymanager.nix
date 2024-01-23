{ pkgs, config, ... }:

{
  services.xserver.displayManager = {
    # enable = true;
    # layout = "us";
    # xkbVariant = "";
    # libinput.enable = true;
    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    }
  };
}

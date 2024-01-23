{ pkgs, config, theKBDLayout, ... }:

{
  services.xserver = {
    enable = true;
    layout = "${theKBDLayout}";
    xkbVariant = "";
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
  };
}

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

  environment.systemPackages = let themes = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {}; in [ 
    themes.sddm-sugar-dark 
  ];
}

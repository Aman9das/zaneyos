{ pkgs, config, ... }:

{
  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    libinput.enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  sound.enable = true;
  security.rtkit.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}

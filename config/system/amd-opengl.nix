{ pkgs, config, lib, deviceProfile, ... }:

lib.mkIf ("${deviceProfile}" == "amd-desktop") {
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}

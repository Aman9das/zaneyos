{ pkgs, config, lib, ... }:

libmkIf (${deviceProfile} == "amd-desktop") {
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}

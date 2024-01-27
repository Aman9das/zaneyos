{ pkgs, config, lib, gpuType, ... }:

lib.mkIf ("${gpuType}" == "amd") {
  # OpenGL
  hardware.opengl = {
    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}

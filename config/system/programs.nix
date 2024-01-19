{ config, pkgs, userPrograms, ... }:

{
  # List System Programs
  environment.systemPackages = with pkgs; [
    "${userPrograms}"
  ];
}

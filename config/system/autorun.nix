{ pkgs, config, ... }:

{
  system.activationScripts = {
    swayncreloader.text = ''
        swaync-client -R
        swaync-client -rs
    '';
  };
}

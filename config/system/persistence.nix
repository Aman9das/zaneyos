{ config, pkgs, lib, username, ... }:

let
  inherit (import ../../options.nix) impermanence;
in lib.mkIf (impermanence == true) {
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      # "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
	"Downloads"
	"Music"
	"Documents"
	"Pictures"
	"Videos"
	".local/share/sddm"
	".mozilla"
	".cache"
	".ssh"
      ];
      files = [
      ];
    };
  };
}

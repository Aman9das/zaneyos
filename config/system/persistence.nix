{ config, pkgs, lib, username, ... }:

{
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
    users.zaney = {
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
	".config/discord"
      ];
      files = [
      ];
    };
  };
}

{ config, pkgs, lib, username, ... }:

{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
	"Downloads"
	"Music"
	"Documents"
	"Pictures"
	"Videos"
	".local/share/sddm"
      ];
      files = [
      ];
    };
  };
}

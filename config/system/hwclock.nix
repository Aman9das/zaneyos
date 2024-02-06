{ config, ... }:

let inherit (import ../../options.nix) localHWClock; in
lib.mkIf ("${localHWClock}" == "on") {
  time.hardwareClockInLocalTime = true;
}

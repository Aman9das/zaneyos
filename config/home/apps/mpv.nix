{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.mpris
      mpvScripts.modernx-zydezu
      mpvScripts.mpv-cheatsheet
      mpvScripts.sponsorblock-minimal
      mpvScripts.youtube-upnext
      mpvScripts.thumbfast
      # mpvScripts.webtorrent-mpv-hook
      # mpvScripts.quality-menu
    ];
    config = {
      volume = 100;
      volume-max = 200;
      # keep-open = "no";

      force-window = "immediate";
      osc = "no";
      osd-bar = "no";
      border = "no";
      osd-font = "RecMonoLinear Nerd Font";

      sub-font = "Recursive Sans Linear Static";
      sub-font-size = 40;
      sub-auto = "fuzzy";

      screenshot-directory = "~/pictures/mpv-screenshots/";
      title = "\${?media-title:\${media-title}}\${!media-title:No file.}";

      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      script-opts = "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp,ytdl_hook-try_ytdl_first=yes,ytdl_hook-exclude=\"%.webm$|%.ts$|%.mp3$|%.m3u8$|%.m3u$|%.mkv$|%.mp4$|%.VOB$\"";

      # save-position-on-quit = true;
      # resume-playback = "no";

      hwdec = "auto-safe";
      profile = "gpu-hq";
      vo = "gpu";
      ao = "pipewire,";
      gpu-context = "wayland";
      video-sync = "display-resample";

      alang = "bn,Bengali,Bangla,en,eng,jp,jpn,ja,Japanese,japanese";
      slang = "bn,Bengali,Bangla,en,eng,jp,jpn,ja,Japanese,japanese";
    };
  };
}

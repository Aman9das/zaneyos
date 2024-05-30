{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-menu
  ];

  home.file.".config/bwm/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu

    [dmenu_passphrase]
    obscure = True
    obscure_color = #222222

    [vault]
    server_1 = https://vault.bitwarden.com
    email_1 = amandas62640@gmail.com
    twofactor_1 = -1
    editor = nvim
    terminal = kitty
    type_library = wtype
    session_timeout_min = 60
    autotype_default = {USERNAME}{TAB}{PASSWORD}{ENTER}
  '';

  # programs.rbw = {
  #   enable = true;
  #   settings = {
  #     email = "amandas62640@gmail.com";
  #     base_url = "https://api.bitwarden.com/";
  #     lock_timeout = 300;
  #     pinentry = pkgs.pinentry-gnome3;
  #   };
  # };
}

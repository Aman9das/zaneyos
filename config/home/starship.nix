{ pkgs, config, ... }:

{
  # Starship Prompt
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = {
        add_newline = true;
        character = {
            success_symbol = "[➜](bold blue)";
            error_symbol = "[➜](bold red)";
        };
        package = {
            disabled = false;
        };
    };
  };
}

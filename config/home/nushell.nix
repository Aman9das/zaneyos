{
  pkgs,
  config,
  host,
  ...
}: let
  inherit (import ../../hosts/${host}/options.nix) flakeDir theShell hostname;
  shellAliases = {
    sv = "sudo nvim";
    flake-rebuild = "nh os switch --hostname ${hostname}";
    flake-update = "nh os switch --hostname ${hostname} --update";
    v = "nvim";
    ls = "ls";
    ll = "ls -l";
    la = "ls -a";
    lal = "ls -al";
    ".." = "cd ..";
    neofetch = "neofetch --off";
    "db" = "distrobox";
    "nv" = "nvim";

    ":q" = "exit";
    "q" = "exit";
  };
in {
  home.packages = with pkgs; [
    carapace
  ];

  programs = {
    nushell = {
      inherit shellAliases;
      enable = true;
      environmentVariables = {
        PROMPT_INDICATOR_VI_INSERT = "\"  \"";
        PROMPT_INDICATOR_VI_NORMAL = "\"∙ \"";
        PROMPT_COMMAND = ''""'';
        PROMPT_COMMAND_RIGHT = ''""'';
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = ''"${pkgs.nushell}/bin/nu"'';
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
      extraConfig = let
        conf = builtins.toJSON {
          show_banner = false;
          edit_mode = "vi";
          shell_integration = true;

          ls.clickable_links = true;
          rm.always_trash = true;

          table = {
            mode = "compact"; # compact thin rounded
            index_mode = "always"; # always never auto
            header_on_separator = false;
          };

          cursor_shape = {
            vi_insert = "line";
            vi_normal = "block";
          };

          menus = [
            {
              name = "completion_menu";
              only_buffer_difference = false;
              marker = "? ";
              type = {
                layout = "columnar"; # list, description
                columns = 4;
                col_padding = 2;
              };
              style = {
                text = "magenta";
                selected_text = "blue_reverse";
                description_text = "yellow";
              };
            }
          ];
        };
        completions = let
          completion = name: ''
            source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
          '';
        in
          names:
            builtins.foldl'
            (prev: str: "${prev}\n${str}") ""
            (map (name: completion name) names);
      in ''
        $env.config = ${conf};
        ${completions ["cargo" "git" "nix" "npm" "curl" "gh" "man" "rg"]}

        source ~/.cache/carapace/init.nu
        def gcCleanup [] {
          nix-collect-garbage --delete-old
          sudo nix-collect-garbage -d
          sudo /run/current-system/bin/switch-to-configuration boot
          }
      '';
      extraEnv = ''
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
        mkdir ~/.cache/carapace
        carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
      '';
    };
  };
}

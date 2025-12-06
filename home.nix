{
  config,
  pkgs,
  ...
}: {
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = "26.05";

  home.file.${config.xdg.configHome} = {
    enable = true;
    source = ./dotfiles/.;
    recursive = true;
  };

  home.packages = with pkgs; [
    quickshell
    brightnessctl
    hyprlauncher

    jdk21_headless
    nil
    alejandra
    python313
    python313Packages.pydbus

    google-chrome
    telegram-desktop
    libreoffice
    bitwarden-desktop
    jetbrains.idea-community
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      wallpaper = [
        ",~/Images/corgi_dog_sleeping_on_the_doorstep-wallpaper-1920x1080.jpg"
      ];
    };
  };

  home.shell.enableZshIntegration = true;
  programs.kitty.shellIntegration.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    loginExtra = ''
      if [ -z $WAYLAND_DISPLAY ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start -- hyprland-uwsm.desktop
      fi
    '';
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = ["git"];
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor.line-number = "relative";
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "alejandra";
          };
        }
      ];
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "crackedglass";
      user.email = "bunin.basil@yandex.ru";
    };
  };

  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.sioyek.enable = true;
  programs.obsidian = {
    enable = true;
    vaults.obsidian-main-vault.enable = true;
    defaultSettings.appearance = {
      cssTheme = "TimeStone";
      theme = "obsidian";
      accentColor = "#65ba5a";
    };
  };

  # programs.wofi.enable = true;
  services.cliphist.enable = true;
  services.wl-clip-persist.enable = true;
}

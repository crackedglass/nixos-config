{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = "26.05";

  imports = [
    ./configs/helix.nix
  ];

  home.file.${config.xdg.configHome} = {
    enable = true;
    source = ./dotfiles/.;
    recursive = true;
  };

  home.packages = with pkgs; [
    # quickshell
    brightnessctl
    # hyprlauncher
    # hyprtoolkit
    # hyprmon

    jdk21_headless
    nil
    alejandra
    python313
    python313Packages.pydbus
    gcc
    cargo
    rustc
    clippy
    rust-analyzer
    rustfmt
    typst
    tinymist
    typstyle

    google-chrome
    telegram-desktop
    libreoffice
    bitwarden-desktop
    jetbrains.idea-community
    claude-code-router
    poppler-utils
  ];

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  };

  xdg.desktopEntries = {
    sioyek = {
      name = "sioyek";
      exec = "sioyek --new-instance %f";
      terminal = false;
      mimeType = ["application/pdf"];
    };
  };
  # xdg.mimeApps.defaultApplications = {
  #   "text/plain" = "helix.desktop";
  #   "application/pdf" = "sioyer.desktop";
  # };

  home.shell.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # loginExtra = ''
    #   if [ -z $WAYLAND_DISPLAY ] && [ "$XDG_VTNR" = 1 ]; then
    #     exec uwsm start -- hyprland-uwsm.desktop
    #   fi
    # '';
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = ["git"];
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

  programs.bun = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.gh.enable = true;
  programs.claude-code.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.sioyek = {
    enable = true;
    bindings = {
      "zoom_in" = "=";
      "fit_to_page_width" = "+";
    };
    config = {
      "background_color" = "0.0 0.0 0.0";
      "should_launch_new_window" = "1";
      "page_separator_width" = "5";
      "page_separator_color" = "0.0 0.0 0.0";
    };
  };
  programs.obsidian = {
    enable = true;
    vaults.obsidian-main-vault.enable = true;
    defaultSettings.appearance = {
      cssTheme = "TimeStone";
      theme = "obsidian";
      accentColor = "#65ba5a";
    };
  };
  programs.jq.enable = true;
  programs.lazydocker.enable = true;

  # programs.wofi.enable = true;
  # services.cliphist.enable = true;
  # services.wl-clip-persist.enable = true;
  # programs.wlogout.enable = true;
  programs.bluetuith.enable = true;
}

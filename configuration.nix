{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  virtualisation.docker.enable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocales = ["ru_RU.UTF-8/UTF-8"];

  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_US.UTF8";
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
    LC_COLLATE = "ru_RU.UTF-8";
  };

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  services.printing.enable = true;
  services.upower.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  services.udisks2.enable = true;

  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
      "networkmanager"
    ];
  };

  programs.zsh.enable = true;
  users.extraUsers.ilya = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    alacritty
    google-chrome
    git
    linuxPackages_latest.amneziawg
    ffmpeg
    intel-media-driver

    # KDE
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdiff3
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    hardinfo2
    vlc
    wayland-utils
    wl-clipboard
    brightnessctl
  ];
  programs.amnezia-vpn.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    nerd-fonts.fira-code
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    eb-garamond
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "26.05";
}

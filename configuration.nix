{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  hardware.cpu.intel.updateMicrocode = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };

    efi.canTouchEfiVariables = true;
    timeout = 2;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/42f4a716-e8cf-4f51-b4b0-491bb837cbb0";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "noatime"
        "space_cache"
        "compress-force=zstd"
        "discard=async"
        "commit=120"
      ];
    };

    "boot" = {
      device = "/dev/disk/by-uuid/7D11-1CD3";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/42f4a716-e8cf-4f51-b4b0-491bb837cbb0";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "noatime"
        "space_cache"
        "compress-force=zstd"
        "discard=async"
        "commit=120"
      ];
    };

    "/opt" = {
      device = "/dev/disk/by-uuid/42f4a716-e8cf-4f51-b4b0-491bb837cbb0";
      fsType = "btrfs";
      options = [
        "subvol=@opt"
        "noatime"
        "space_cache"
        "compress-force=zstd"
        "discard=async"
        "commit=120"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/45c3133d-8e73-4877-a9d5-1e6796eec17e";
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "btrfs" "i915" "thunderbolt" "amdgpu" ];
  boot.blacklistedKernelModules = [ "psmouse" ];

  networking.hostName = "nixostest";
  networking.wireless.enable = false;
  networking.useDHCP = false;
  networking.interfaces.wlp59s0.useDHCP = false;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  users.mutableUsers = false;
  users.users.michiel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    useDefaultShell = false;
    shell = pkgs.zsh;
    passwordFile = "/etc/nixos/michiel.passwd";
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
    };

    git.enable = true;

    gnome-terminal.enable = true;
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs

    gnome.gnome-shell
    gnome.gnome-session
    gnome.mutter
    gnome.adwaita-icon-theme
    gnome.gnome-tweaks
    gnome.gnome-control-center
    gnome.gnome-themes-extra
    gnome.gnome-settings-daemon

    xdg-user-dirs
    
    vscode
    firefox-wayland
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;

    media-session.enable = true;
  };

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      cantarell-fonts
      jetbrains-mono
    ];
  };

  services.xserver = {
    enable = true;

    libinput.enable = true;
    libinput.touchpad.tapping = false;
    libinput.touchpad.naturalScrolling = true;

    displayManager.gdm.enable = true;
    displayManager.sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
  };

  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    };

    autostart.enable = true;
  };

  powerManagement.enable = true;
  services.upower.enable = true;

  system.stateVersion = "21.11";
}

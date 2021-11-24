{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./fileSystems.nix
      ./services.nix
      ./packages.nix
    ];

  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.enable = true;
  hardware.pulseaudio.enable = false;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };

    efi.canTouchEfiVariables = true;
    timeout = 2;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "btrfs" "i915" "thunderbolt" "amdgpu" ];
  boot.blacklistedKernelModules = [ "psmouse" ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';

  networking.hostName = "nixostest";
  networking.wireless.enable = false;
  networking.useDHCP = false;
  networking.interfaces.wlp59s0.useDHCP = false;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "nl_NL.UTF-8/UTF-8"
    ];
  };

  users = {
    mutableUsers = false;

    users.michiel = {
      description = "Michiel Lowijs";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      useDefaultShell = false;
      shell = pkgs.zsh;
      passwordFile = "/etc/nixos/michiel.passwd";
    };
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      jetbrains-mono
    ];
  };

  system.stateVersion = "21.11";
}

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

  networking.hostName = "nixostest";
  networking.wireless.enable = false;
  networking.useDHCP = false;
  networking.interfaces.wlp59s0.useDHCP = false;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    mutableUsers = false;

    users.michiel = {
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
      cantarell-fonts
      jetbrains-mono
    ];
  };

  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    };

    autostart.enable = true;
  };

  system.stateVersion = "21.11";
}

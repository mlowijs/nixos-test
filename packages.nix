{ pkgs, ... }:

{
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
}
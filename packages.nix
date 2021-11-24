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

    gnome.gnome-tweaks
    
    vscode
    firefox-wayland
  ];
}

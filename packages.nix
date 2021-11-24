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

    xwayland.enable = true;
  
    npm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs

    gnome.gnome-tweaks
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.bluetooth-quick-connect
    
    firefox-wayland
    slack
    bitwarden

    vscode
    jetbrains.rider
    dotnet-sdk
    dotnet-runtime
    dotnet-aspnetcore
    nodejs-16_x
  ];
}

{ pkgs, ... }:

{
  services.logind.killUserProcesses = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;

    media-session.enable = true;
  };

  services.xserver = {
    enable = true;

    libinput.enable = true;
    libinput.touchpad.tapping = false;
    libinput.touchpad.naturalScrolling = true;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.gnome = {
    core-utilities.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };
}

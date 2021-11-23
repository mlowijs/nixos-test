{ pkgs, ... }:

{
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
    displayManager.sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
  };

  services.upower.enable = true;
}
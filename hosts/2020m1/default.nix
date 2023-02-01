# hosts/2020m1/default.nix
{ pkgs, lib, ... }:
{

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  services.nix-daemon.package = pkgs.nixFlakes;
  
  programs.zsh.enable = true;
  programs.fish.enable = true;


  homebrew = {
   enable = true;
   onActivation.autoUpdate = true;
   # onActivation.autoUpgrade = true;
   # updates homebrew packages on activation,
   # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
   casks = [
     "hammerspoon"
     "rectangle"
     "alfred"
     # "logseq"
     "discord"
     # "iina"
   ];
  };

  system.defaults = {
    dock.autohide = true;
  };
}

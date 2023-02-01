# hosts/2020m1/default.nix
{ pkgs, lib, ... }:
{

  # Make sure the nix daemon always runs
  # services.nix-daemon.enable = true;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;
  nix.useDaemon = true;
  
  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = [
    pkgs.direnv
    pkgs.emacs
    pkgs.fzf
    pkgs.git
    pkgs.starship
    pkgs.vim
    pkgs.silver-searcher
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.hamishhutchings = { pkgs, ... }: {

    stateVersion = "22.05"; # read below

    programs.tmux = { # my tmux configuration, for example
      enable = true;
      keyMode = "vi";
      clock24 = true;
      historyLimit = 10000;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        gruvbox
      ];
      extraConfig = ''
        new-session -s main
        bind-key -n C-a send-prefix
      '';
    };
  };


  # TODO: clean up manually installed brew casks...
  homebrew = {
   enable = true;
   onActivation.autoUpdate = true;
   # onActivation.autoUpgrade = true;
   # updates homebrew packages on activation,
   # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
   casks = [
     # "hammerspoon"
     "rectangle"
     "alfred"
     # "logseq"
     # "discord"
     # "iina"
   ];
  };

  system.defaults = {
    dock.autohide = true;
  };
}

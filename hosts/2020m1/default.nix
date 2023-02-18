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

    programs.home-manager.enable = true;
    home.stateVersion = "22.05"; # read below

    programs.tmux = { # my tmux configuration, for example
      enable = true;
      keyMode = "vi";
      clock24 = true;
      historyLimit = 10000;
      prefix = "M-b";
      plugins = with pkgs.tmuxPlugins; [
        # vim-tmux-navigator
        yank
        pain-control
        {
			plugin = dracula;
			extraConfig = ''
				set -g @dracula-refresh-rate 10
				set -g @dracula-show-battery false
				set -g @dracula-show-powerline true
                set -g @dracula-cpu-usage true
                set -g @dracula-military-time true
                set -g @dracula-ram-usage true
                set -g @dracula-show-fahrenheit false
			'';
		}
      ];
      extraConfig = ''
      '';
    };

    home.packages = with pkgs; [
      direnv
      emacs
      fzf
      git
      starship
      vim
      ripgrep
      silver-searcher
      jq
      httpie
      flyctl
      htop

      # cleanup
      go
    ];
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
     "stoplight-studio"
     # "logseq"
     # "discord"
     "vlc"
   ];
  };

  system.defaults = {
    dock.autohide = false;
  };
}

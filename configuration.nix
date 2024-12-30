{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;     

  networking = {
    networkmanager = {
      enable = true;
    };
  };

  systemd = {
    services = {
      NetworkManager-wait-online = {
        enable = false;
      };    
    };
  };
  
  time.timeZone = "America/Toronto";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  
  optimise.automatic = true;
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # List of packages installed in system profile.
  environment = {
    systemPackages = with pkgs; [
    
    ];
  };

  programs = {};

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        flags = [
          "--all"
          "--volumes"
        ];
      };
    };
  };

  system.stateVersion = "24.11";

}
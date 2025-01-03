{ modulesPath, ... }:

{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];
      
  networking = {
    hostName = "nixbox";
  };
  
  boot = {
    initrd = { checkJournalingFS = false; };
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot/efi"; 
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      efiInstallAsRemovable = true;
    };
  };
  
  services = {
    dbus = { enable = true; };
    timesyncd = { enable = true; };
  };
  
  virtualisation = {
    vmware = {
      guest = { enable = true; };
    };
  };
  
  security.sudo.extraConfig =
      ''
        Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
        Defaults:root,%wheel env_keep+=NIX_PATH
        Defaults:root,%wheel env_keep+=TERMINFO_DIRS
        Defaults env_keep+=SSH_AUTH_SOCK
        Defaults lecture = never
        root   ALL=(ALL) SETENV: ALL
        %wheel ALL=(ALL) NOPASSWD: ALL, SETENV: ALL
      '';
  
}

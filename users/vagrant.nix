{ pkgs, ... }:

{
  users = {
    # Creates a "vagrant" group & user with password-less sudo access
    groups.vagrant = {
      name = "vagrant";
      members = [ "vagrant" ];
    };
    # Creates a "root" user with password "vagrant"
    users = { 
      root = { password = "vagrant"; }; 
      vagrant = {
        isNormalUser = true;
        description = "Vagrant User";
        group = "vagrant";
        extraGroups = [
          "users" 
          "wheel"
          "networkmanager"
          "docker"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3WV4+xb+waKjkHIDnkNTEPz/umtdhzRbDHTkr8qGk9 vagrant-only"
        ];
        shell = pkgs.zsh;
        packages = with pkgs; [];
      };
    };    
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.vagrant = {
      home = {
        stateVersion = "24.11";
      };
    };
  };
}

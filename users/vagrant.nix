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
          "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
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

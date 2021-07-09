{ pkgs, ... }:

# the Chia daemon, isolated in an container for the purpose of farming
#
# NOTE: should have been called chia-farmer since it's not just a harvester

{
  containers.chia-harvester = {
    autoStart = true;
    config = { ... }: {
      # FIXME: this is a copy-paste of modules/minimalize.nix
      security.sudo.enable = false;
      security.polkit.enable = false;
      environment.defaultPackages = [ ];

      users.users.chia = {
        isNormalUser = true;
        packages = with pkgs; [
          chia
        ];
      };
      systemd.services.chia-farmer = {
        script = "${pkgs.chia}/bin/chia run_daemon";
        postStart = "${pkgs.chia}/bin/chia start farmer-no-wallet";
        preStop = "${pkgs.chia}/bin/chia stop all";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          RestartSec = "1s";
          Restart = "always";
          User = "chia";
        };
      };
      networking.firewall.allowedTCPPorts = [ 8444 8449 ];
    };
    forwardPorts = [
      {
        hostPort = 8444;
      }
      {
        hostPort = 8449;
      }
    ];

    bindMounts = {
      "/srv/chia" = {
        hostPath = "/srv/chia";
        isReadOnly = true;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 8444 8449 ];
}

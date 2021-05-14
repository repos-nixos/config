{ pkgs, ... }:

# the Chia daemon, isolated in an ephemeral container for the purpose of harvesting

{
  containers.chia-harvester = {
    autoStart = true;
    config = { ... }: {
      users.users.chia = {
        isNormalUser = true;
        packages = with pkgs; [
          chia
        ];
      };
      systemd.services.chia-node = {
        script = "${pkgs.chia}/bin/chia run_daemon";
        postStart = "${pkgs.chia}/bin/chia start farmer";
        preStop = "${pkgs.chia}/bin/chia stop all";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          RestartSec = "1s";
          Restart = "always";
          User = "chia";
        };
      };
      networking.firewall.allowedTCPPorts = [ 8444 ];
    };
    forwardPorts = [{
      hostPort = 8444;
    }];

    bindMounts = {
      "/srv/chia" = {
        hostPath = "/srv/chia";
        isReadOnly = true;
      };
    };
  };
}

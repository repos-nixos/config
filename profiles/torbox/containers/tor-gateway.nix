let
  hostAddress = "10.0.4.1";
  localAddress = "10.0.4.2";
  forwardPorts = [
    8118 # privoxy
    9050 # isolated tor
  ];
in
{
  containers.tor-gateway = {
    privateNetwork = true;
    inherit hostAddress localAddress;
    forwardPorts = map (p: { hostPort = p; }) forwardPorts;

    config = { pkgs, ... }: {
      services.tor = {
        enable = true;
        client.enable = true;
        client.socksListenAddress = { IsolateDestAddr = true; addr = "0.0.0.0"; port = 9050; };
        controlSocket.enable = true;
      };

      services.privoxy = {
        enable = true;
        enableTor = true;
        settings.listen-address = "0.0.0.0:8118";
      };

      environment.systemPackages = with pkgs; [ nyx ];

      networking.firewall.allowedTCPPorts = forwardPorts;
    };
  };

  # Tor itself needs outside access.
  networking.nat = {
    enable = true;
    internalIPs = [ localAddress ];
  };

  # Bonus feature: torsocks works on the host as well when container is running.
  services.tor.torsocks = {
    enable = true;
    server = "${localAddress}:9050";
  };
}

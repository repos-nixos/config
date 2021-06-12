{
  services.tor = {
    enable = true;
    client.enable = true;
    client.socksListenAddress = { IsolateDestAddr = true; addr = "0.0.0.0"; port = 9050; };
    controlSocket.enable = true;
  };
}

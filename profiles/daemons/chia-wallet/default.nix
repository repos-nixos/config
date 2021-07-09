{ pkgs, ... }:

# a Chia daemon with the wallet

{
  containers.chia-wallet = {
    ephemeral = true;
    config = { ... }: {
      users.users.chia = {
        isNormalUser = true;
        packages = with pkgs; [
          chia
        ];
      };
    };
    bindMounts = {
      "/home/chia" = {
        hostPath = "/home/chia";
        isReadOnly = false;
      };
      # To be used as at temporary plotting directory, should be a fast disk
      "/var/tmp/chia" = {
        hostPath = "/var/tmp/chia";
        isReadOnly = false;
      };
    };
  };
}

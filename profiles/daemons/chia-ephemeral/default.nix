{ pkgs, ... }:

# the Chia daemon, isolated in an ephemeral container

{
  containers.chia-ephemeral = {
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
      # To be used as at temporary plotting directory, should be a fast disk
      "/var/tmp/chia" = {
        hostPath = "/var/tmp/chia";
        isReadOnly = false;
      };
    };
  };
}

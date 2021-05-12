{ pkgs, ... }:

# the Chia daemon, isolated in an ephemeral container

{
  containers.chia = {
    ephemeral = true;
    config = { ... }: {
      users.users.chia = {
        isNormalUser = true;
        openssh.authorizedKeys.keyFiles = [
          users/louis/id_gpgcard.pub
        ];
        packages = with pkgs; [
          chia
        ];
      };
    };
    bindMounts = {
      "/var/tmp/chia" = {
        hostPath = "/var/tmp/chia";
        isReadOnly = false;
      };
    };
  };
}

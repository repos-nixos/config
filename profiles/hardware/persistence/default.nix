{
  environment.persistence."/persist" = {
    directories = [
      "/var/db/sudo"
      "/var/log"
      "/var/lib/libvirt"
      "/var/lib/systemd/coredump"
      "/var/lib/transmission"
      "/etc/ssh"
      "/etc/miniguests"
    ];
    files = [
      "/etc/nix/key.private"
    ];
  };
  fileSystems."/persist".neededForBoot = true;
}

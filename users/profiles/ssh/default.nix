{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      trusted-machines = {
        host = "hadron hadronsson hadronsson-wl";
        forwardAgent = true;
        extraOptions = {
          StrictHostKeyChecking = "yes";
        };
      };

      quark = {
        host = "quark";
        user = "root";
        extraOptions = {
          StrictHostKeyChecking = "yes";
        };
      };

      # surprisingly good heuristic
      git-catchall = {
        host = "*git*";
        user = "git";
      };
    };
  };
}

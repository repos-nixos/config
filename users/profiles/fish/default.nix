{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./prompt_init.fish;
    shellAbbrs = {
      g = "git";
      n = "nix";
    };
    functions.fish_title = ''
      # prefix with remote host if applicable
      if set -q SSH_TTY
        echo -n (prompt_hostname)": "
      end

      # just show the abbreviated current working directory
      echo (prompt_pwd)
    '';
  };
}

{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./prompt_init.fish;
    shellAbbrs = with builtins; fromTOML (readFile ../abbrevs.toml);
    functions.fish_title = ''
      # prefix with remote host if applicable
      if set -q SSH_TTY
        echo -n (prompt_hostname)": "
      end

      # show the abbreviated current working directory
      echo (prompt_pwd)

      # show the running command
      set command (status current-command)
      test $command = fish && set -e command
      echo -n " ["$command]
    '';
  };
}

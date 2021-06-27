{
  programs.bash = {
    enable = true;
    shellAliases = with builtins; fromTOML (readFile ../abbrevs.toml);
  };
}

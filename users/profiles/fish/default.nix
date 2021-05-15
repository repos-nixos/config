{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./prompt_init.fish;
  };
}

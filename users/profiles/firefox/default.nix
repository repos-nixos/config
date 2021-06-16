{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
    ];

    profiles.default = {
      id = 0;
      settings = {
        # disable FF pocket
        "extensions.pocket.enabled" = false;

        # junk blocking
        "browser.contentblocking.category" = "strict";

        # Search Engine
        "browser.search.extra.1" = "DuckDuckGo";

        # disable built-in password management
        "signon.rememberSignons" = false;

        # Ctrl+Tab cycles through tabs in recently used order
        "browser.ctrlTab.sortByRecentlyUsed" = true;

        # Search for text when I start typing
        "accessibility.typeaheadfind" = true;
      };
    };
  };
}

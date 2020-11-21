channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    android-studio
    brave
    cachix
    dhall
    discord
    element-desktop
    firefox
    firefox-bin
    manix
    nixpkgs-fmt
    obs-studio
    qutebrowser
    signal-desktop
    starship
    thunderbird-bin
    tor-browser-bundle-bin
    vscode-with-extensions
    vscodium;


  haskellPackages = prev.haskellPackages.override {
    overrides = hfinal: hprev:
      let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
      in
      {
        # same for haskell packages, matching ghc versions
        inherit (channels.latest.haskell.packages."ghc${version}")
          haskell-language-server;
      };
  };

}

{ pkgs, ... }:

{
  programs.brave = {
    enable = pkgs.system == "x86_64-linux";

    extensions = [
      "hkgfoiooedgoejojocmhlaklaeopbecg" # Picture-in-picture by Google
      "pbcodcjpfjdpcineamnnmbkkmkdpajjg" # Link to text fragment by Google
      "eekailopagacbcdloonjhbiecobagjci" # Go back with Backspace by Google
      "fllaojicojecljbmefodhfapmkghcbnh" # Google Analytics opt-out
      "gbiekjoijknlhijdjbaadobpkdhmoebb" # Google Adds opt-out
    ];
  };
}

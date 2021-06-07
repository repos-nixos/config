{ pkgs, ... }:

{
  programs.brave = {
    enable = pkgs.system == "x86_64-linux";

    extensions = [
      "hkgfoiooedgoejojocmhlaklaeopbecg" # Picture-in-picture by Google
      "pbcodcjpfjdpcineamnnmbkkmkdpajjg" # Link to text fragment by Google
      "fllaojicojecljbmefodhfapmkghcbnh" # Google Analytics opt-out
      "gbiekjoijknlhijdjbaadobpkdhmoebb" # Google Adds opt-out
    ];
  };
}

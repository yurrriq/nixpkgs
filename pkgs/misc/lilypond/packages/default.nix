{ callPackage, lilypond }:

{

  gridly = callPackage ./gridly.nix { inherit lilypond; };

  notation-fonts = callPackage ./notation-fonts.nix { inherit lilypond; };

  oll-core = callPackage ./oll-core.nix { inherit lilypond; };

}

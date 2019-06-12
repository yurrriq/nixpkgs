{ stdenv, lndir, symlinkJoin, makeWrapper, lilypond, openlilylib-fonts, fonts }:

assert builtins.all (x: builtins.hasAttr x openlilylib-fonts) fonts;

let
  getFont = let _fonts = openlilylib-fonts.override { inherit lilypond; }; in
    fontName: builtins.getAttr fontName _fonts;
in

stdenv.lib.appendToName "with-fonts" (symlinkJoin {
  inherit (lilypond) meta name version;

  paths = [ lilypond ] ++ map getFont fonts;

  buildInputs = [ makeWrapper lndir ];

  postBuild = ''
    for p in $out/bin/*; do
        wrapProgram "$p" --set LILYPOND_DATADIR "$datadir"
    done
  '';
})

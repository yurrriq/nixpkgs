{ fetchFromGitHub, lib, lilypond, stdenvNoCC }:

let
  pname = "notation-fonts";
in

stdenvNoCC.mkDerivation {
  inherit pname;
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "openlilylib";
    repo = pname;
    rev = "c1fcd40e9e2625d9e8fd94dc605480a38179c5ef";
    sha256 = "sha256-mCFjOTrCZ0j413op6k7Q875vqdqGsglEuvDKCZTfUdg=";
  };

  dontBuild = true;
  installPhase = ''
    runHook preInstall
    local LILYPOND_DATADIR="$out"/share/lilypond/${lilypond.version}
    install -m755 -d "$LILYPOND_DATADIR"/ly
    cp -rv . "$LILYPOND_DATADIR"/ly/${pname}
    runHook postInstall
  '';

  meta = with lib; {
    inherit (lilypond.meta) platforms;
    inherit (src.meta) homepage;
    description = "Choose alternative notation fonts for GNU LilyPond";
    license = licenses.gpl3;
    maintainers = with maintainers; [ yurrriq ];
  };
}

{ fetchFromGitHub, lib, lilypond, stdenvNoCC }:

let
  pname = "gridly";
in

stdenvNoCC.mkDerivation {
  inherit pname;
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "openlilylib";
    repo = pname;
    rev = "baa175b9c5cc3ff038d266610a0e3dd371d21e71";
    sha256 = "sha256-DtcFkXjj13uuxMeMX5puq+wYw645XmdDp5+hCb85+oc=";
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
    description = "Simple segmented grid for LilyPond";
    license = licenses.gpl3;
    maintainers = with maintainers; [ yurrriq ];
  };
}

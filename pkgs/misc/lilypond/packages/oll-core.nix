{ fetchFromGitHub, lib, lilypond, stdenvNoCC }:

let
  pname = "oll-core";
in

stdenvNoCC.mkDerivation {
  inherit pname;
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "openlilylib";
    repo = pname;
    rev = "6362634d4115ee4d1ff4de79fc54278509e70b16";
    sha256 = "sha256-pd86eDEsHeNQzwOs+DHtaV6gBTz0Kn4rwCbtYVXCm68=";
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
    description = "Library Infrastructure for LilyPond add-ons";
    license = licenses.gpl3;
    maintainers = with maintainers; [ yurrriq ];
  };
}

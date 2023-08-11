{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "chicago95-gtk-theme";
  version = "3.0.1";

  src = fetchFromGitHub {
    owner = "grassmunk";
    repo = "Chicago95";
    rev = "v${version}";
    hash = "sha256-EHcDIct2VeTsjbQWnKB2kwSFNb97dxuydAu+i/VquBA=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/{themes,icons}
    cp -ar Theme/Chicago95 $out/share/themes
    cp -ar Icons/* $out/share/icons
    runHook postInstall
  '';

  meta = with lib; {
    description = "A rendition of everyone's favorite 1995 Microsoft operating system for Linux";
    homepage = "https://github.com/grassmunk/Chicago95";
    license = with licenses; [gpl3Plus mit];
    maintainers = [maintainers.pluiedev];
    platforms = platforms.unix;
  };
}

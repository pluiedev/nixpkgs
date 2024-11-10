{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wrapGAppsHook3,
  gobject-introspection,
  libwnck,
  gtk3,
  pygobject3,
  xlib,
  dbus-python,
  nix-update-script,
}:
let
  version = "0.4.0";
in
buildPythonPackage {
  pname = "quicktile";
  inherit version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ssokolow";
    repo = "quicktile";
    rev = "refs/tags/v${version}";
    hash = "sha256-YDTIjjRpMopVnI7CvtfvMPzdCPRfDEn/zS18niWe58g=";
  };

  build-system = [ setuptools ];

  nativeBuildInputs = [
    wrapGAppsHook3
    gobject-introspection
  ];

  buildInputs = [
    libwnck
    gtk3
  ];

  dependencies = [
    pygobject3
    xlib
    dbus-python
  ];

  pythonImportsCheck = [ "quicktile" ];

  doCheck = false; # Requires nose :(

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Keyboard-driven Window Tiling for your existing X11 window manager";
    homepage = "https://ssokolow.com/quicktile/";
    license = with lib.licenses; [ gpl2Only ];
    # Darwin support is not officially supported so use at your own risk
    # https://ssokolow.com/quicktile/faq.html#does-quicktile-run-on-macos
    platforms = with lib.platforms; linux ++ darwin;
    maintainers = with lib.maintainers; [ pluiedev ];
    mainProgram = "quicktile";
  };
}

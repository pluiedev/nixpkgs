{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:
let
  version = "0.5.0";
in
rustPlatform.buildRustPackage {
  pname = "television";
  inherit version;

  src = fetchFromGitHub {
    owner = "alexpasmantier";
    repo = "television";
    rev = "refs/tags/${version}";
    hash = "sha256-yi8lPm3zkmamN6gPlGfojNlIXM1cgSr1zL2zMNni5f0=";
  };

  cargoHash = "sha256-1SdyVtMjkfXH9iGew9i8xpx8WlUly4vIcKY3weeW3LQ=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Blazingly fast general purpose fuzzy finder for your terminal written in Rust";
    homepage = "https://github.com/alexpasmantier/television";
    changelog = "https://github.com/alexpasmantier/television/releases/tag/${version}";
    platforms = lib.platforms.unix;
    license = with lib.licenses; [ mit ];
    maintainers = with lib.maintainers; [ pluiedev ];
    mainProgram = "tv";
  };
}

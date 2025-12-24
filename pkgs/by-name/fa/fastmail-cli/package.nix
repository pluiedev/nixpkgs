{
  lib,
  buildGoModule,
  fetchFromGitHub,
  versionCheckHook,
}:
buildGoModule (finalAttrs: {
  pname = "fastmail-cli";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "salmonumbrella";
    repo = "fastmail-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-y8svvMJbFRnjLkyqlEWPV3CL9aIeblL9zIede7VYM4M=";
  };

  vendorHash = "sha256-Or1pbvZlDvnKCQ9qFoJmZ3fpd2RfykcmD1bMB8Km9XA=";

  # See Makefile
  ldflags = [
    "-s"
    "-w"
    "-X github.com/salmonumbrella/fastmail-cli/internal/cmd.Version=${finalAttrs.version}"
    "-X github.com/salmonumbrella/fastmail-cli/internal/cmd.Commit=Nixpkgs"
    "-X github.com/salmonumbrella/fastmail-cli/internal/cmd.Date=1970-01-01T00:00:00Z"
  ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  meta = {
    description = "Command-line interface for Fastmail email and masked email management";
    homepage = "https://github.com/salmonumbrella/fastmail-cli";
    maintainers = with lib.maintainers; [
      pluiedev
    ];
  };
})

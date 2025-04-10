{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "gopls";
  version = "0.18.1";

  src = fetchFromGitHub {
    owner = "golang";
    repo = "tools";
    rev = "gopls/v${version}";
    hash = "sha256-5w6R3kaYwrZyhIYjwLqfflboXT/z3HVpZiowxeUyaWg=";
  };

  modRoot = "gopls";
  vendorHash = "sha256-/tca93Df90/8K1dqhOfUsWSuFoNfg9wdWy3csOtFs6Y=";

  # https://github.com/golang/tools/blob/9ed98faa/gopls/main.go#L27-L30
  ldflags = [ "-X main.version=v${version}" ];

  doCheck = false;

  # Only build gopls, gofix, modernize, and not the integration tests or documentation generator.
  subPackages = [
    "."
    "internal/analysis/gofix/cmd/gofix"
    "internal/analysis/modernize/cmd/modernize"
  ];

  meta = with lib; {
    description = "Official language server for the Go language";
    homepage = "https://github.com/golang/tools/tree/master/gopls";
    changelog = "https://github.com/golang/tools/releases/tag/${src.rev}";
    license = licenses.bsd3;
    maintainers = with maintainers; [
      mic92
      rski
      SuperSandro2000
      zimbatm
    ];
    mainProgram = "gopls";
  };
}

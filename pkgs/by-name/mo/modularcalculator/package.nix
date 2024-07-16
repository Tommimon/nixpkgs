{
  lib,
  fetchFromGitHub,
  python3Packages,
  qt6,
  makeDesktopItem,
  copyDesktopItems,
}:
python3Packages.buildPythonApplication rec {
  pname = "modularcalculator";
  version = "1.5.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "JordanL2";
    repo = "ModularCalculatorInterface";
    rev = "refs/tags/v${version}";
    hash = "sha256-Im1mZ9kJB+0uPAmEXpUAAAYBooejes05vTGLDqPCAN4=";
  };

  postPatch = ''
  '';

  buildInputs = [ qt6.qtwayland ];

  nativeBuildInputs = [
    qt6.wrapQtAppsHook
    python3Packages.hatchling
    python3Packages.hatch-vcs
    copyDesktopItems
  ];

  propagatedBuildInputs = with python3Packages; [
    darkdetect
    pillow
    platformdirs
    pyqrcode
    pyqt6
    python-barcode
    pyusb
    rich
    typer
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "Modular Calculator";
      exec = "modularcalculator";
      desktopName = "Modular Calculator";
    })
  ];

  meta = {
    changelog = "https://github.com/JordanL2/ModularCalculatorInterface/releases/tag/${src.rev}";
    description = "A powerful, scriptable, modular calculator aimed at scientific, engineering or computing work.";
    homepage = "https://github.com/JordanL2/ModularCalculatorInterface";
    license = lib.licenses.asl20;
        platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Tommimon ];
    mainProgram = "modularcalculator";
  };
}

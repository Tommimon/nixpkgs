{
  lib,
  fetchFromGitHub,
  python3Packages,
  qt6,
  makeDesktopItem,
  copyDesktopItems,
}:
let
  modularcalculatorPinned = python3Packages.modularcalculator.overridePythonAttrs (oldAttrs: rec {
    version = "1.4.3";
    src = fetchFromGitHub {
      owner = "JordanL2";
      repo = "ModularCalculator";
      rev = "refs/tags/${version}";
      hash = "sha256-ZgGuw/+/GtsKxGHjinDxNs/bZZG/Du3GA9/oe+YqKyQ=";
    };
  });
in
python3Packages.buildPythonApplication rec {
  pname = "modularcalculator-qt";
  version = "1.5.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "JordanL2";
    repo = "ModularCalculatorInterface";
    rev = "refs/tags/${version}";
    hash = "sha256-SUkJc/4xD9C4VzBHD12e+WV0ta/3/oS1toVwORLEo34=";
  };

  postPatch = ''
  '';

  buildInputs = [ qt6.qtwayland ];

  nativeBuildInputs = [
    qt6.wrapQtAppsHook
    python3Packages.hatchling
    python3Packages.hatch-vcs
    python3Packages.pyyaml
    python3Packages.modularcalculator
    python3Packages.scipy
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
    pyyaml
    scipy
    modularcalculatorPinned
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "Modular Calculator";
      exec = "modularcalculator";
      desktopName = "Modular Calculator";
      icon = "modularcalculator-qt";
    })
  ];

  postInstall = ''
    cp -r $src/config $out/config
    for size in 16 24 48 64 128 256; do
      install -Dm644 $src/icons/''${size}x''${size}.png $out/share/icons/hicolor/''${size}x''${size}/apps/modularcalculator-qt.png || true
    don
  '';

  meta = {
    description = "A powerful, scriptable, modular calculator aimed at scientific, engineering or computing work.";
    homepage = "https://github.com/JordanL2/ModularCalculatorInterface";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ Tommimon ];
    mainProgram = "modularcalculator";
  };
}

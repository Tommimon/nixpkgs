{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchpatch,
  setuptools,
  strct,
  pytestCheckHook,
  pyyaml,
  scipy
}:

buildPythonPackage rec {
  pname = "modularcalculator";
  version = "1.4.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "JordanL2";
    repo = "ModularCalculator";
    rev = "refs/tags/${version}";
    hash = "sha256-BabOE+e50bE6z2EUmiLIs6GmSv7u/nrc+GKhOzf5W8Y=";
  };

  nativeBuildInputs = [
    setuptools 
    pyyaml
    scipy
  ];

  propagatedBuildInputs = [
    pyyaml
    scipy
  ];

  dependencies = [ strct ];

  meta = {
    description = "Powerful modular calculator engine.";
    homepage = "https://github.com/JordanL2/ModularCalculatorInterface";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ Tommimon ];
  };
}

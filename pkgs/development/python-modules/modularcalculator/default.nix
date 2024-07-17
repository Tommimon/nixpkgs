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
  version = "1.4.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "JordanL2";
    repo = "ModularCalculator";
    rev = "refs/tags/${version}";
    hash = "sha256-jgeIqqq8tM9gnxdQ3YOeNxg6NB5jMsaiIcyLosJKR+A=";
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

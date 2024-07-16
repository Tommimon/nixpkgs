{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchpatch,
  setuptools,
  strct,
  pytestCheckHook,
  pyyaml,
}:

buildPythonPackage rec {
  pname = "modularcalculator";
  version = "1.4.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "JordanL2";
    repo = "ModularCalculator";
    rev = "refs/tags/${version}";
    hash = "sha256-KdQZzQJvJ+loAAAAQfaqqEEZJ/9VmNTQX/a4v0oBC98=";
  };

  nativeBuildInputs = [ setuptools ];

  dependencies = [ strct ];

  pythonImportsCheck = [
    "birch"
    "birch.casters"
    "birch.exceptions"
    "birch.paths"
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pyyaml
  ];

  preCheck = ''
    export HOME="$(mktemp -d)"
  '';

  meta = {
    description = "Powerful modular calculator engine.";
    homepage = "https://github.com/JordanL2/ModularCalculatorInterface";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ Tommimon ];
  };
}

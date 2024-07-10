{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  libGL,
  libxkbcommon,
  hyprlang,
  hyprutils,
  pam,
  wayland,
  wayland-protocols,
  cairo,
  file,
  libjpeg,
  libwebp,
  pango,
  libdrm,
  mesa,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprlock";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "hyprwm";
    repo = "hyprlock";
    rev = "0552a1edddead3b956e5ceaa19001c056deccb57";
    hash = "sha256-CaEdn0yrfIGpluvk6Hs6FRr1jLjn6k6vzKb0FzqXTsc=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    cairo
    file
    hyprlang
    hyprutils
    libdrm
    libGL
    libjpeg
    libwebp
    libxkbcommon
    mesa
    pam
    pango
    wayland
    wayland-protocols
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Hyprland's GPU-accelerated screen locking utility";
    homepage = "https://github.com/hyprwm/hyprlock";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ iynaix ];
    mainProgram = "hyprlock";
    platforms = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
})

{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  cmake,
  pkg-config,
  wrapQtAppsHook,
  alsa-lib ? null,
  carla ? null,
  fftwFloat,
  fltk_1_3,
  fluidsynth ? null,
  lame ? null,
  libgig ? null,
  libjack2 ? null,
  libpulseaudio ? null,
  libsamplerate,
  libsoundio ? null,
  libsndfile,
  libvorbis ? null,
  portaudio ? null,
  qtbase,
  qtx11extras,
  qttools,
  SDL2 ? null,
}:

stdenv.mkDerivation (finalAttrs: {
  name = "lmms";
  # version = "1.2.2";

  src = fetchFromGitHub {
    owner = "LMMS";
    repo = "lmms";
    rev = "0f0d972b5282041c861517365d3f48379276020c";
    hash = "sha256-zdMPtd9fJ+LS5cywTWi/6Y3x32ayFWxX9+PJboSvRwQ=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    qttools
    pkg-config
    wrapQtAppsHook
  ];

  buildInputs = [
    carla
    alsa-lib
    fftwFloat
    fltk_1_3
    fluidsynth
    lame
    libgig
    libjack2
    libpulseaudio
    libsamplerate
    libsndfile
    libsoundio
    libvorbis
    portaudio
    qtbase
    qtx11extras
    SDL2
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DWANT_QT5=ON"
  ];

  # meta = {
  #   description = "DAW similar to FL Studio (music production software)";
  #   mainProgram = "lmms";
  #   homepage = "https://lmms.io";
  #   license = lib.licenses.gpl2Plus;
  #   platforms = lib.platforms.linux;
  #   maintainers = [ ];
  # };
})

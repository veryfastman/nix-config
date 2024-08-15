{ fetchFromGitHub, stdenv }:
stdenv.mkDerivation {
  name = "gruvbox-sddm-theme";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "tbjers";
    repo = "gruvbox-sddm-theme";
    rev = "44bde52b19e5735140bdf89ef8da78ac607523fa";
    sha256 = "1vwsgn19v8cam74bhs91knb0zayyzfx0qszdij9xlrj41yd13s1k";
  };
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/gruvbox-sddm-theme
  '';
}

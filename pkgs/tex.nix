{ texlive }:
texlive.combine {
  inherit (texlive) scheme-basic dvisvgm dvipng wrapfig amsmath ulem hyperref capt-of;
}

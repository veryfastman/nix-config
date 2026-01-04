{
  flake.homeModules.mpv =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.misc.mpv;
    in
    {
      options.misc.mpv.enable = mkEnableOption "Enable MPV";

      config = mkIf cfg.enable {
        programs.mpv = {
          enable = true;

          package =
            with pkgs;
            (mpv.override {
              youtubeSupport = true;
              scripts = [ mpvScripts.mpris ];
            });

          config = {
            hwdec = "auto";
            ytdl-format = "ytdl";
            term-playing-msg = "Now playing: \${media-title}";
          };
        };
      };
    };
}

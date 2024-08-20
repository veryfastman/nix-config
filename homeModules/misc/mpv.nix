{
  flake.homeModules.mpv =
    { config
    , lib
    , pkgs
    , ...
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

          package = with pkgs; (mpv-unwrapped.wrapper {
            mpv = (mpv-unwrapped.override {
              ffmpeg = ffmpeg_7-full;
            });
            youtubeSupport = true;
            scripts = [ mpvScripts.mpris ];
          });

          config = {
            ytdl-format = "ytdl";
          };
        };
      };
    };
}

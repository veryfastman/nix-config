{
  flake.homeModules.mime =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.misc.mime;
    in
    {
      options.misc.mime = {
        enable = mkEnableOption "Enable xdg-mime settings";
      };

      config = mkIf cfg.enable {
        xdg.mime.enable = true;
        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "application/x-terminal-emulator" = [ "Alacritty.desktop" ];
            "application/xhtml+xml" = [ "zen-beta.desktop" ];
            "application/pdf" = [ "org.pwmt.zathura.desktop" ];
            "image/apng" = [ "imv.desktop" ];
            "image/astc" = [ "imv.desktop" ];
            "image/avif" = [ "imv.desktop" ];
            "image/bmp" = [ "imv.desktop" ];
            "image/cgm" = [ "imv.desktop" ];
            "image/dpx" = [ "imv.desktop" ];
            "image/emf" = [ "imv.desktop" ];
            "image/g3fax" = [ "imv.desktop" ];
            "image/gif" = [ "imv.desktop" ];
            "image/heif" = [ "imv.desktop" ];
            "image/ief" = [ "imv.desktop" ];
            "image/jp2" = [ "imv.desktop" ];
            "image/jpeg" = [ "imv.desktop" ];
            "image/jpm" = [ "imv.desktop" ];
            "image/jpx" = [ "imv.desktop" ];
            "image/jxl" = [ "imv.desktop" ];
            "image/jxr" = [ "imv.desktop" ];
            "image/ktx" = [ "imv.desktop" ];
            "image/ktx2" = [ "imv.desktop" ];
            "image/openraster" = [ "imv.desktop" ];
            "image/png" = [ "imv.desktop" ];
            "image/qoi" = [ "imv.desktop" ];
            "image/rle" = [ "imv.desktop" ];
            "image/svg+xml" = [ "imv.desktop" ];
            "image/svg+xml-compressed" = [ "imv.desktop" ];
            "image/tiff" = [ "imv.desktop" ];
            "image/vnd.adobe.photoshop" = [ "imv.desktop" ];
            "image/vnd.djvu" = [ "imv.desktop" ];
            "image/vnd.djvu+multipage" = [ "imv.desktop" ];
            "image/vnd.dwg" = [ "imv.desktop" ];
            "image/vnd.dxf" = [ "imv.desktop" ];
            "image/vnd.microsoft.icon" = [ "imv.desktop" ];
            "image/vnd.ms-modi" = [ "imv.desktop" ];
            "image/vnd.rn-realpix" = [ "imv.desktop" ];
            "image/vnd.wap.wbmp" = [ "imv.desktop" ];
            "image/vnd.zbrush.pcx" = [ "imv.desktop" ];
            "image/webp" = [ "imv.desktop" ];
            "image/wmf" = [ "imv.desktop" ];
            "image/x-3ds" = [ "imv.desktop" ];
            "image/x-adobe-dng" = [ "imv.desktop" ];
            "image/x-applix-graphics" = [ "imv.desktop" ];
            "image/x-bzeps" = [ "imv.desktop" ];
            "image/x-canon-cr2" = [ "imv.desktop" ];
            "image/x-canon-cr3" = [ "imv.desktop" ];
            "image/x-canon-crw" = [ "imv.desktop" ];
            "image/x-cmu-raster" = [ "imv.desktop" ];
            "image/x-compressed-xcf" = [ "imv.desktop" ];
            "image/x-dcraw" = [ "imv.desktop" ];
            "image/x-dds" = [ "imv.desktop" ];
            "image/x-dib" = [ "imv.desktop" ];
            "image/x-eps" = [ "imv.desktop" ];
            "image/x-exr" = [ "imv.desktop" ];
            "image/x-fpx" = [ "imv.desktop" ];
            "image/x-fuji-raf" = [ "imv.desktop" ];
            "image/x-gimp-gbr" = [ "imv.desktop" ];
            "image/x-gimp-gih" = [ "imv.desktop" ];
            "image/x-gimp-pat" = [ "imv.desktop" ];
            "image/x-gzeps" = [ "imv.desktop" ];
            "image/x-icns" = [ "imv.desktop" ];
            "image/x-ilbm" = [ "imv.desktop" ];
            "image/x-jng" = [ "imv.desktop" ];
            "image/x-jp2-codestream" = [ "imv.desktop" ];
            "image/x-kodak-dcr" = [ "imv.desktop" ];
            "image/x-kodak-k25" = [ "imv.desktop" ];
            "image/x-kodak-kdc" = [ "imv.desktop" ];
            "image/x-lwo" = [ "imv.desktop" ];
            "image/x-lws" = [ "imv.desktop" ];
            "image/x-macpaint" = [ "imv.desktop" ];
            "image/x-minolta-mrw" = [ "imv.desktop" ];
            "image/x-msod" = [ "imv.desktop" ];
            "image/x-niff" = [ "imv.desktop" ];
            "image/x-nikon-nef" = [ "imv.desktop" ];
            "image/x-nikon-nrw" = [ "imv.desktop" ];
            "image/x-olympus-orf" = [ "imv.desktop" ];
            "image/x-panasonic-rw" = [ "imv.desktop" ];
            "image/x-panasonic-rw2" = [ "imv.desktop" ];
            "image/x-pentax-pef" = [ "imv.desktop" ];
            "image/x-photo-cd" = [ "imv.desktop" ];
            "image/x-pict" = [ "imv.desktop" ];
            "image/x-portable-anymap" = [ "imv.desktop" ];
            "image/x-portable-bitmap" = [ "imv.desktop" ];
            "image/x-portable-graymap" = [ "imv.desktop" ];
            "image/x-portable-pixmap" = [ "imv.desktop" ];
            "image/x-quicktime" = [ "imv.desktop" ];
            "image/x-rgb" = [ "imv.desktop" ];
            "image/x-sgi" = [ "imv.desktop" ];
            "image/x-sigma-x3f" = [ "imv.desktop" ];
            "image/x-skencil" = [ "imv.desktop" ];
            "image/x-sony-arw" = [ "imv.desktop" ];
            "image/x-sony-sr2" = [ "imv.desktop" ];
            "image/x-sony-srf" = [ "imv.desktop" ];
            "image/x-sun-raster" = [ "imv.desktop" ];
            "image/x-tga" = [ "imv.desktop" ];
            "image/x-tiff-multipage" = [ "imv.desktop" ];
            "image/x-win-bitmap" = [ "imv.desktop" ];
            "image/x-xbitmap" = [ "imv.desktop" ];
            "image/x-xcf" = [ "imv.desktop" ];
            "image/x-xcursor" = [ "imv.desktop" ];
            "image/x-xfig" = [ "imv.desktop" ];
            "image/x-xpixmap" = [ "imv.desktop" ];
            "image/x-xwindowdump" = [ "imv.desktop" ];
            "text/html" = [ "zen-beta.desktop" ];
            "video/3gpp" = [ "mpv.desktop" ];
            "video/3gpp2" = [ "mpv.desktop" ];
            "video/annodex" = [ "mpv.desktop" ];
            "video/dv" = [ "mpv.desktop" ];
            "video/isivideo" = [ "mpv.desktop" ];
            "video/mj2" = [ "mpv.desktop" ];
            "video/mp2t" = [ "mpv.desktop" ];
            "video/mp4" = [ "mpv.desktop" ];
            "video/mpeg" = [ "mpv.desktop" ];
            "video/ogg" = [ "mpv.desktop" ];
            "video/quicktime" = [ "mpv.desktop" ];
            "video/vnd.avi" = [ "mpv.desktop" ];
            "video/vnd.mpegurl" = [ "mpv.desktop" ];
            "video/vnd.radgamettools.bink" = [ "mpv.desktop" ];
            "video/vnd.radgamettools.smacker" = [ "mpv.desktop" ];
            "video/vnd.rn-realvideo" = [ "mpv.desktop" ];
            "video/vnd.vivo" = [ "mpv.desktop" ];
            "video/vnd.youtube.yt" = [ "mpv.desktop" ];
            "video/wavelet" = [ "mpv.desktop" ];
            "video/webm" = [ "mpv.desktop" ];
            "video/x-anim" = [ "mpv.desktop" ];
            "video/x-flic" = [ "mpv.desktop" ];
            "video/x-flv" = [ "mpv.desktop" ];
            "video/x-javafx" = [ "mpv.desktop" ];
            "video/x-matroska" = [ "mpv.desktop" ];
            "video/x-matroska-3d" = [ "mpv.desktop" ];
            "video/x-mjpeg" = [ "mpv.desktop" ];
            "video/x-mng" = [ "mpv.desktop" ];
            "video/x-ms-wmv" = [ "mpv.desktop" ];
            "video/x-nsv" = [ "mpv.desktop" ];
            "video/x-ogm+ogg" = [ "mpv.desktop" ];
            "video/x-sgi-movie" = [ "mpv.desktop" ];
            "video/x-theora+ogg" = [ "mpv.desktop" ];
            "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
            "x-scheme-handler/http" = [ "zen-beta.desktop" ];
            "x-scheme-handler/https" = [ "zen-beta.desktop" ];
            "x-scheme-handler/terminal" = [ "Alacritty.desktop" ];
          };
        };
      };
    };
}

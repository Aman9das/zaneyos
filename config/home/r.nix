{ pkgs, config, lib, ... }:
with pkgs;
let
  rpkgs = with rPackages; [
    tidyverse
    quarto tinytex
    MASS zoo slider
    GGally readODS
    ISLR2
    languageserversetup languageserver
  ];
  my-rstudio = pkgs.rstudio.overrideAttrs (finalAttrs: previousAttrs: {
      darkstudioSrc = fetchFromGitHub {
      owner = "rileytwo";
      repo = "darkstudio";
      rev = "4d1a3519186a8b43368d37417309497e28dd65a0";
      hash = "sha256-CGohdXxFGBkFzE3os8P1XVkXCS6mVCgMy6acq9sFtL4=";
      };

      postInstall = previousAttrs.postInstall + ''
      cp ${finalAttrs.darkstudioSrc}/inst/resources/darkstudio.css $out/lib/rstudio/www
      cp $out/lib/rstudio/www/index.htm $out/lib/rstudio/www/index.htm.bak
      sed -i '/<\/html>/i <link rel="stylesheet" href="darkstudio.css" type="text/css">' $out/lib/rstudio/www/index.htm
      '';
    }
  );
  r-set = rWrapper.override { packages = rpkgs; };
  rstudio-set = rstudioWrapper.override{ packages = rpkgs; rstudio = my-rstudio; };
  radian-set = radianWrapper.override{ packages = rpkgs; };
  quarto-set = quarto.override{ extraRPackages = rpkgs; };
 in
{
  # R
  home.packages = with pkgs; [
    r-set rstudio-set radian-set
    quarto-set
    texliveFull
  ];
}

{ config, pkgs, lib, ... }:

{
  # services.nginx = {
  #   enable = true;
  #   recommendedTlsSettings = true;
  #   recommendedOptimisation = true;
  #   recommendedGzipSettings = true;
  #   recommendedProxySettings = true;

  #   virtualHosts = {
  #     # "mediaserver.local" = {
  #     # 
  #     # };

  #     "jellyfin.mediaserver.local" = {
  #       locations."/" = {
  #         proxyPass = "http://localhost:8096";
  #       };
  #     };
  #   };
  # };
}

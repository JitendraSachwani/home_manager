{ pkgs, config, user, ... }:

let
  nginxPkg = pkgs.nginx;
  pidFile = "hm_nginx.pid";
  pidFilePath = "${config.home.homeDirectory}/run/${pidFile}";
  confFile = ".config/hm_nginx.conf";
  confPath = "${config.home.homeDirectory}/${confFile}";
  logsFoler = "logs/hm_nginx";
  errorLogFile = "${logsFoler}/error.log";
  accessLogFile = "${logsFoler}/access.log";
  errorLogPath = "${config.home.homeDirectory}/${errorLogFile}";
  accessLogPath = "${config.home.homeDirectory}/${accessLogFile}";
  execCmd = "${pkgs.nginx}/bin/nginx -c ${confPath} -g \"pid ${pidFilePath};\" -e ${errorLogPath}";
in
{
  config = {
    systemd.user.services.hm_nginx = {
      Unit = {
        Description = "[HomeManager] - NGINX server";
        # After = syslog.target network.target remote-fs.target nss-lookup.target
      };
      Service = {
        # Type = "exec";
        Type = "forking";
        ExecStartPre = "${execCmd} -t ";
        ExecStart = "${execCmd}";
        ExecReload = "/bin/kill -s HUP $MAINPID";
        ExecStop = "/bin/kill -s QUIT $MAINPID";
        PIDFile = "${pidFilePath}";
        PrivateTmp = true;
        # Restart = "on-failure";
      };

      Install = {
        # WantedBy = [ "default.target" ];
        WantedBy = [ "multi-user.target" ];
      };
    };

    home.file."${confFile}".text = ''
      worker_processes  2;
      error_log ${errorLogPath} info;

      events {
        use epoll;
        worker_connections 128;
      }

      http {
          server_tokens off;
          # include mime.types;
          charset utf-8;

          access_log ${accessLogPath} combined;

          server {
            listen 8080;
            server_name jellyfin.mediaserver.local;

            location / {
                proxy_pass http://127.0.0.1:8096;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            }
        }
      }
    '';

    home.file."${logsFoler}/.keep".text = "";

    home.file.".xyz".text = ''
      ${pkgs.lib.concatStringsSep "\n" (pkgs.lib.attrNames(config.home.path))}
    '';
  };
}

{ config, pkgs, lib, ... }:

let
  pidFoler = "run/";
  logsFoler = "logs/";
in
{
  home.file = {

    # Common Dotfiles  
    ".aliases".source = ./common/dotfiles/.aliases;
    ".bash_logger.sh".source = ./common/dotfiles/.bash_logger.sh;
    ".gemrc".source = ./common/dotfiles/.gemrc;
    ".vimrc".source = ./common/dotfiles/.vimrc;
    ".zshrc".source = ./common/dotfiles/.zshrc;

    # Custom Dotfiles
    ".custom_aliases".source = ./custom/dotfiles/.aliases;
    ".bash_aliases".source = ./common/dotfiles/.aliases;

    "${pidFoler}/.keep".text = "This folder holds all the pid files";
    "${logsFoler}/.keep".text = "This folder holds all the log folders";
  };
}

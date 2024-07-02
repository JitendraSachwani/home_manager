{ config, pkgs, lib, ... }:

{
  home.file = {
    
    # Common Dotfiles  
    ".bash_aliases".source = ./common/dotfiles/.aliases;
    ".bash_logger.sh".source = ./common/dotfiles/.bash_logger.sh;
    ".gemrc".source = ./common/dotfiles/.gemrc;
    ".vimrc".source = ./common/dotfiles/.vimrc;
    ".zshrc".source = ./common/dotfiles/.zshrc;

    # Custom Dotfiles
    ".custom_aliases".source = ./custom/dotfiles/.aliases;
    
  };
}

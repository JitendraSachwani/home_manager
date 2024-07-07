{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "JitendraSachwani";
    userEmail = "sachwani.jitendra@gmail.com";
  };
}

# Cursor configuration
{ pkgs, ... }:
{
  stylix.cursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
  };
}

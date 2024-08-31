# System users
{ ... }:
{
  users.users.thibaut = {
    isNormalUser = true;
    description = "Thibaut";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

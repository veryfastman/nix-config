let
  donny = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVFH0/bdFSXgx0BqBLyDRAnG5ZjDDrbOUHbIOeTzXPD";
  users = [ donny ];
in
{
  "donnyPassword.age".publicKeys = [ donny ];
}

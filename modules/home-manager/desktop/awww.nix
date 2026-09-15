{ inputs, system, ... }:

{
  home.packages = [ inputs.awww.packages.${system}.default ];
}

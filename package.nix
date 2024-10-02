{ stdenv
, lib
, fetchFromGitHub
, crystal
, wrapGAppsHook4
, gi-crystal
}:
crystal.buildCrystalPackage rec {
  pname = "myhotkeys";
  version = "0.2.1";

  src = ./.;

#  src = fetchFromGitHub {
#    owner = "mipmip";
#    repo = "gnome-hotkeys.cr";
#    rev = "v${version}";
#    hash = "";
#  };

  nativeBuildInputs = [ wrapGAppsHook4 gi-crystal ];
  buildInputs = [ ];

  buildTargets = [ "all" ];
  doCheck = false;

  shardsFile = ./shards.nix;

  #installTargets = [ "install" "install-fonts"];
  doInstallCheck = false;

  meta = with lib; {
    description = "Fast popup window with configured hotkeys";
    homepage = "https://github.com/mipmip/gnome-hotkeys.cr";
    license = licenses.mit;
    mainProgram = "myhotkeys";
    maintainers = with maintainers; [ sund3RRR ];
  };
}

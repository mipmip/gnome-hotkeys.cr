{ stdenv
, lib
, fetchFromGitHub
, crystal
, shards
, wrapGAppsHook4
, gobject-introspection
, gtk4
, libadwaita
, dnsutils
}:
crystal.buildCrystalPackage rec {
  pname = "myhotkeys";
  version = "0.2.2";

  src = ./.;

#  src = fetchFromGitHub {
#    owner = "mipmip";
#    repo = "gnome-hotkeys.cr";
#    rev = "v${version}";
#    hash = "";
#  };

  nativeBuildInputs = [ wrapGAppsHook4 gobject-introspection ];
  buildInputs = [ gtk4 libadwaita ];

  postPatch = ''
    substituteInPlace Makefile \
      --replace-fail "shards install" "true"
  '';

  preBuild = ''
    cd lib/gi-crystal && shards build -Dpreview_mt --release --no-debug
    cd ../.. && mkdir bin/ && cp lib/gi-crystal/bin/gi-crystal bin/
  '';

  buildTargets = [ "all" ];
  doCheck = false;

  shardsFile = ./shards.nix;
  copyShardDeps = true;

  #installTargets = [ "install" ];
  doInstallCheck = false;

  meta = with lib; {
    description = "Fast popup window with configured hotkeys";
    homepage = "https://github.com/mipmip/gnome-hotkeys.cr";
    license = licenses.mit;
    mainProgram = "myhotkeys";
    maintainers = with maintainers; [ sund3RRR ];
  };
}

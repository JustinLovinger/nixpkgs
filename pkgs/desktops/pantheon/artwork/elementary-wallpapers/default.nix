{ stdenv
, fetchFromGitHub
, pantheon
}:

stdenv.mkDerivation rec {
  pname = "elementary-wallpapers";
  version = "5.3";

  repoName = "wallpapers";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = version;
    sha256 = "1i0zf9gzhwm8hgq5cp1xnxipqjvgzd9wfiicz612hgp6ivc0z0ag";
  };

  passthru = {
    updateScript = pantheon.updateScript {
      inherit repoName;
      attrPath = pname;
    };
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/share/backgrounds/elementary
    cp -av *.jpg $out/share/backgrounds/elementary
  '';

  meta = with stdenv.lib; {
    description = "Collection of wallpapers for elementary";
    homepage = https://github.com/elementary/wallpapers;
    license = licenses.publicDomain;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}


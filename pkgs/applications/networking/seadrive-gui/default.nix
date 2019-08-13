{ cmake
, fetchFromGitHub
, makeWrapper
, pkgconfig
, stdenv
# Package dependencies
, libsearpc
, libselinux
, libsepol
, libuuid
, pcre
, qttools
, qtwebengine
, seadrive-daemon
}:

stdenv.mkDerivation rec {
  pname = "seadrive-gui";
  version = "1.0.7";

  src = fetchFromGitHub {
    owner = "haiwen";
    repo = pname;
    rev = "v${version}";
    sha256 = "1dm7f2d631rjlhhvfnsvm8p749gqrcvjpqxi5gbhfq4hxbbn5xmd";
  };

  patches = [ ./fix_webkit_webengine.patch ];

  nativeBuildInputs = [
    cmake
    makeWrapper
    pkgconfig
  ];
  buildInputs = [
    libsearpc
    libselinux
    libsepol
    libuuid # Satisfies the 'mount' package requirement. Contains 'mount.pc'
    pcre
    qttools
    qtwebengine
    seadrive-daemon
  ];

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];

  postInstall = ''
    makeWrapper ${seadrive-daemon}/bin/seadrive $out/bin/seadrive
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/haiwen/seadrive-gui;
    description = "GUI part of Seafile drive";
    license = licenses.asl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ justinlovinger ];
  };
}

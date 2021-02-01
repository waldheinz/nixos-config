{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "10.4.12";
  name = "typo3-${version}";

  src = fetchurl {
    url = "https://typo3.azureedge.net/typo3/${version}/typo3_src-${version}.tar.gz";
    hash = "sha256-D4hPUoRDo45sFo8oSuyi2bv/a22fynlh9AZnwqNTzos=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

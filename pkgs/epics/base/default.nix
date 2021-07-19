{ lib
, mkEpicsPackage
, fetchgit
, version ? "7.0.6"
, sha256 ? ""
, local_config_site ? { }
, local_release ? { }
}:

let
  versions = lib.importJSON ./versions.json;
  hash = if sha256 != "" then sha256 else versions.${version}.sha256;
in
mkEpicsPackage {
  pname = "epics-base";
  inherit version;
  varname = "EPICS_BASE";

  inherit local_config_site local_release;

  isEpicsBase = true;

  src = fetchgit {
    url = "https://git.launchpad.net/epics-base";
    rev = "R${version}";
    sha256 = hash;
  };
}

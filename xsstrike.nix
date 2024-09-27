{ pkgs ? import <nixpkgs> {} }:

let
  python3Packages = pkgs.python3Packages;
in
pkgs.stdenv.mkDerivation {
    pname = "xsstrike";
    version = "3.1.15";

    src = pkgs.fetchFromGitHub {
        owner = "s0md3v";
        repo = "XSStrike";
        rev = "3.1.5";
        sha256 = "05lbvgq77sgkj671v0yskarima4kqbnbdsip1kxhck5vsm0jiqz1";
    };

    propagatedBuildInputs = [ 
        (pkgs.python3.withPackages (pp:[
            pp.tld
            pp.requests
            pp.fuzzywuzzy
        ]))
    ];

    installPhase = ''
        mkdir -p $out/bin
        cp -r core db modes plugins $out/bin/
        install -m755 xsstrike.py $out/bin/

    '';
}
    
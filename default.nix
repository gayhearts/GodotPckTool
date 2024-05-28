{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
in
  with import <nixpkgs> {};
	stdenv.mkDerivation rec {
	  pname = "godotpcktool";
	  version = "2.0";

	  src = ./.;

	  patches = [];

	  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];
	  enableParallelBuilding = true;

	  nativeBuildInputs = [
	  	clang
		cmake
	  ];

	  postInstall = ''
	    mkdir -p $out/bin
		cp src/godotpcktool $out/bin/godotpcktool
		chmod +x $out/bin/godotpcktool
	  '';

	  meta = with lib; {
		homepage = "https://github.com/gayhearts/godotpcktool";
		description = "A standalone executable for unpacking and packing Godot .pck files.";
		mainProgram = "godotpcktool";
	  };
	}

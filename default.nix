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
	  dontUseCmakeConfigure = true;
	  dontUseCmakeBuildDir = true;

	  nativeBuildInputs = [
	  	clang
		cmake
	  ];

	  postInstall = ''
		install -Dm755 -t $out/bin build/src/godotpcktool
	  '';

	  outputs = [ "out" ];

	  meta = with lib; {
		homepage = "https://github.com/gayhearts/godotpcktool";
		description = "A standalone executable for unpacking and packing Godot .pck files.";
		mainProgram = "godotpcktool";
	  };
	}

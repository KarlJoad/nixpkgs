{ buildOctavePackage
, lib
, fetchurl
# Octave Dependencies
, splines
# Other Dependencies
, gmsh
, awk
, dolfin
}:

buildOctavePackage rec {
  pname = "msh";
  version = "1.0.10";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1mb5qrp9y1w1cbzrd9v84430ldy57ca843yspnrgbcqpxyyxbgfz";
  };

  requiredOctavePackages = [
    splines
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Create and manage triangular and tetrahedral meshes for Finite Element or Finite Volume PDE solvers";
    longDescription = ''
      Create and manage triangular and tetrahedral meshes for Finite Element or
      Finite Volume PDE solvers. Use a mesh data structure compatible with
      PDEtool. Rely on gmsh for unstructured mesh generation.
    '';
    # Marked this way until KarlJoad gets gmsh, awk, and dolfin as runtime dependencies.
    broken = true;
  };
}

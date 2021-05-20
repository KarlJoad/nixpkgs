{ stdenv
, lib
, darwin
, fetchFromGitLab
, blas
, lapack
, mpi
, petsc
, gfortran
, python3
}:

stdenv.mkDerivation rec {
  pname = "SLEPc";
  version = "3.15.0";

  src = fetchFromGitLab {
    owner = "petsc";
    repo = "petsc";
    rev = "v${version}";
    sha256 = "0a505lm10r59s3m2ijnmv2jgcz99pvgbqicjdvh5j9gvp0kvp5vs";
  };

  sourceRoot = "source";

  # Like petsc, upstream does some hot she-py-bang stuff. See petsc for more details.
  # inherit (petsc) prePatch;
  prePatch = ''
    substituteInPlace configure \
      --replace /bin/sh ${python3}/bin/python
  '' + lib.optionalString stdenv.isDarwin ''
    substituteInPlace config/install.py \
      --replace /usr/bin/install_name_tool ${darwin.cctools}/bin/install_name_tool
  '';

  # PETSC_ARCH does not need to be set because Nix already provides separation of
  # different versions of programs in a way that will never cause conflicts.
  preConfigure = ''
    export SLEPC_DIR=${sourceRoot}
    export PETSC_DIR=${petsc}
  '';

  # --with-precision=__float128 on systems with GNU compilers (gcc-4.6 or later)
  configureFlags = [
    "--with-scalar-type=complex"
    "--with-precision=single"
    "--with-fc=0" # Disable searching for Fortran compiler
    "--with-fortran-bindings=0" # Build with Fortran, but do not use bindings
    "--with-blas-lapack-lib=[${blas}/lib/libblas.so,${lapack}/lib/liblapack.so,${gfortran.cc.lib}/lib/libgfortran.a]"
    "--with-64-bit-indices=1" # Use 8 byte integers for array indexing
    "--with-shared-libraries=0" # Build static libraries, instead of shared
    "--with-debugging=0" # Disable error checking
    "--with-cuda=1" # Enable GPU compute
    "--with-mpi=0" # Disable MPI
  ];

  nativeBuildInputs = [
    blas
    lapack
    mpi
    petsc
    python3
  ];

  doCheck = true;

  meta = with lib; {
    description = ''
      A software library for the solution of large scale sparse eigenvalue problems
      on parallel computers. It is an extension of PETSc and can be used for linear
      eigenvalue problems in either standard or generalized form, with real or complex
      arithmetic. It can also be used for computing a partial SVD of a large, sparse,
      rectangular matrix, and to solve nonlinear eigenvalue problems (polynomial or
      general). Additionally, SLEPc provides solvers for the computation of the action
      of a matrix function on a vector.
    '';
    homepage = "https://slepc.upv.es/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ KarlJoad ];
    platforms = platforms.all;
  };
}

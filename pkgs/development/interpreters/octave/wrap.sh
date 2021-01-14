unlinkDirReSymlinkContents() {
    local dirToUnlink="$1"
    local origin="$2"
    local contentsLocation="$3"

    unlink $dirToUnlink/$contentsLocation
    mkdir -p $dirToUnlink/$contentsLocation
    for f in $origin/$contentsLocation/*; do
        ln -s -t "$dirToUnlink/$contentsLocation" "$f"
    done
}

createOctavePackagesPath() {
    local desiredOut=$1
    local origin=$2

    if [ -L "$out/share" ]; then
	unlinkDirReSymlinkContents "$desiredOut" "$origin" "share"
    fi
    if [ -L "$out/share/octave" ]; then
	unlinkDirReSymlinkContents "$desiredOut" "$origin" "share/octave"
    fi

    # Now that octave_packages has a path rather than symlinks, create the
    # octave_packages directory for installed packages.
    mkdir -p "$desiredOut/share/octave/octave_packages"
}

addPkgLocalList() {
    local desiredOut=$1
    local origin=$2
    local octaveSite="share/octave/site"
    local octaveSiteM="$octaveSite/m"
    local octaveSiteStartup="$octaveSiteM/startup"
    local siteOctavercStartup="$octaveSiteStartup/octaverc"

    unlinkDirReSymlinkContents "$desiredOut" "$origin" "$octaveSite"
    unlinkDirReSymlinkContents "$desiredOut" "$origin" "$octaveSiteM"
    unlinkDirReSymlinkContents "$desiredOut" "$origin" "$octaveSiteStartup"

    unlink "$out/$siteOctavercStartup"
    cp "$origin/$siteOctavercStartup" "$desiredOut/$siteOctavercStartup"
    chmod u+w "$desiredOut/$siteOctavercStartup"
    echo "pkg local_list $out/.octave_packages" >> "$desiredOut/$siteOctavercStartup"
}

wrapOctavePrograms() {
    wrapOctaveProgramsIn "$out/bin" "$out $octavePath"
}

wrapOctaveProgramsIn() {
    local dir="$1"
    local octavePath="$2"
    local pkgs="$3"
    local f

    buildOctavePath "$octavePath" "$pkgs"

    # Find all regular files in the output directory that are executable.
    if [ -d "$dir" ]; then
	find "$dir" -type f -perm -0100 -print0 | while read -d "" f; do
	    echo "wrapping \`$f'..."
	    local -a wrap_args=("$f"
				--prefix PATH ':' "$program_PATH"
			       )
	    local -a wrapProgramArgs=("${wrap_args[@]}")
	    wrapProgram "${wrapProgramArgs[@]}"
	done
    fi
}

# Build the PATH environment variable by walking through the closure of
# dependencies.
buildOctavePath() {
    local octavePath="$1"
    local packages="$2"

    local pathsToSearch="$octavePath $packages"

    # Create an empty table of Octave paths.
    declare -A octavePathsSeen=()
    program_PATH=
    octavePathsSeen["@octave@"]=1
    addToSearchPath program_PATH "@octave@/bin"
    echo "program_PATH to change to is: $program_PATH"
    for path in $pathsToSearch; do
	echo "Recurse to propagated-build-input: $path"
	_addToOctavePath $path
    done
}

# Adds the bin directories to the PATH variable.
# Recurses on any paths declared in `propagated-build-inputs`, while avoiding
# duplicating paths by flagging the directires it has seen in `octavePathsSeen`.
_addToOctavePath() {
    local dir="$1"
    # Stop if we've already visited this path.
    if [ -n "${octavePathsSeen[$dir]}" ]; then return; fi
    octavePathsSeen[$dir]=1
    # addToSearchPath is defined in stdenv/generic/setup.sh. It has the effect
    # of calling `export program_X=$dir/...:$program_X`.
    addToSearchPath program_PATH $dir/bin
    echo "PATH to change to is: $program_PATH"

    # Inspect the propagated inputs (if they exist) and recur on them.
    local prop="$dir/nix-support/propagated-build-inputs"
    if [ -e $prop ]; then
	for new_path in $(cat $prop); do
	    _addToOctavePath $new_path
	done
    fi
}

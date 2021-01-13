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
    local f

    buildOctavePath "$octavePath"

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

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


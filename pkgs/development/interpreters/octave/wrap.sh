unlinkDirReSymlinkContents() {
    local dirToUnlink="$1"
    local contentsLocation="$2"

    unlink $dirToUnlink
    mkdir -p $dirToUnlink
    for f in $contentsLocation/*; do
        ln -s -t "$dirToUnlink" "$f"
    done
}

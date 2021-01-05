unlinkDirReSymlinkContents() {
    local dirToUnlink="$1"
    local contentsLocation="$2"
    echo "Unlink = $dirToUnlink"
    echo "Contents = $contentsLocation"

    unlink $dirToUnlink
    mkdir -p $dirToUnlink
    for f in $contentsLocation/*; do
        echo "ln -s -t $dirToUnlink $f"
        ln -s -t "$dirToUnlink" "$f"
    done
}

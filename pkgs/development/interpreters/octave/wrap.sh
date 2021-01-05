unlinkDirReSymlinkContents() {
    local dirToUnlink="$1"
    local contentsLocation="$2"

    unlink $dirToUnlink
    mkdir -p $dirToUnlink
    for f in "$whereToLinkFrom/*"; do
	ln -s -t $dirToUnlink $f
    done
}

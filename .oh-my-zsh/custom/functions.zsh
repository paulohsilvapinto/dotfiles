# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}


# Navigates to the directory even if the path contains a filename
function cd() {
    if [ $# -eq 0 ] ; then
        # no arguments
        builtin cd
    elif [ -d $1 ] ; then
        # argument is a directory
        builtin cd "$1"
    else
        # argument is not a directory
        builtin cd "$(dirname $1)"
    fi
}

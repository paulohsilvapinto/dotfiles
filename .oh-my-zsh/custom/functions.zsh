# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# automatically runs ls after cd
function chpwd() {
    emulate -L zsh
    ls
}


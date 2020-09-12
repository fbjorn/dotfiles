awp() {
    awk "{print \$$1}"
}

cpu_count() {
    case "$(uname -s)" in
      Darwin)
        sysctl -n hw.ncpu
        ;;
      Linux)
        grep -c processor /proc/cpuinfo
    esac
}

skip_first() {
    # Skips first N lines of the output.
    #
    # Args:
    #     N
    #
    # Example:
    #     $ echo "1\n2\n3" | skip_first 1
    #     2
    #     3

    awk "NR > ${1:=1}"
}

tstamp () {
    # Converts UNIX timestamp into local and UTC.
    #
    # Args:
    #     timestamp
    #
    # Example:
    #     $ tstamp 1425353494
    #     Вт. марта  3 06:31:34 MSK 2015
    #     Вт. марта  3 03:31:34 UTC 2015
    #
    #

    date -d "@$1" && date --utc -d "@$1"
}

dedup() {
    # Removes duplicates from output keeping preserving empty lines.
    #
    # Should be used in pipes only.

    awk '!NF || !seen[$0]++'
}

portu() {
    # Prints who occupies the port.
    #
    # Args:
    #     port_number
    #
    # Example:
    #     $ portu 25
    #     tcp   0.0.0.0:25  1908/master

    if [ $# -ne 1 ]
    then
        echo "Usage: portu <port number>"
        return 1
    fi

    sudo netstat -lnp -A inet | \
        awk -v OFS="\t" -v NUM=".?*$1"'$' 'NR > 2 && $4 ~ NUM {print $1,$4,$7}'
}

filesu() {
    # Prints who uses the given file.
    #
    # Args:
    #     filepath
    #
    # Example:
    #     $ filesu /dev/urandom
    #     indicator 3519    nineseconds
    #     python  3666    nineseconds
    #     dropbox 3736    nineseconds
    #     gvfs-afc-   3771    nineseconds
    #     btsync-co   3798    nineseconds
    #     firefox 3859    nineseconds
    #     vim 4429    nineseconds
    #     python2 4444    nineseconds
    #     python2 4444    nineseconds

    lsof "$1" 2> /dev/null | awk 'NR > 1 {print $1"\t"$2"\t"$3}'
}

filesp() {
    # Prints which files are used by processes with the given name.
    #
    # Args:
    #     process_name
    #
    # Example:
    #     $ filesp zsh
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/compctl.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/stat.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complist.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/parameter.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zutil.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complete.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zle.so
    #     6886    /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/terminfo.so

    lsof -c "$1" 2> /dev/null | awk '{print $2"\t"$9}'
}

filespu() {
    # Prints the list of files for the given processes (unique).
    #
    # Args:
    #     process_name
    #
    # Example:
    #     $ filespu zsh
    #     /
    #     /bin/zsh5
    #     /dev/pts/11
    #     /dev/pts/3
    #     /home/nineseconds/dev/pvt/dotfiles/zsh
    #     /lib/x86_64-linux-gnu/ld-2.19.so
    #     /lib/x86_64-linux-gnu/libc-2.19.so
    #     /lib/x86_64-linux-gnu/libcap.so.2.24
    #     /lib/x86_64-linux-gnu/libdl-2.19.so
    #     /lib/x86_64-linux-gnu/libm-2.19.so
    #     /lib/x86_64-linux-gnu/libnsl-2.19.so
    #     /lib/x86_64-linux-gnu/libnss_compat-2.19.so
    #     /lib/x86_64-linux-gnu/libnss_files-2.19.so
    #     /lib/x86_64-linux-gnu/libnss_nis-2.19.so
    #     /lib/x86_64-linux-gnu/libtinfo.so.5.9
    #     pipe
    #     /usr/lib/locale/locale-archive
    #     /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/compctl.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complete.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/complist.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/computil.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/parameter.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/stat.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/terminfo.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zle.so
    #     /usr/lib/x86_64-linux-gnu/zsh/5.0.5/zsh/zutil.so
    #     /usr/share/zsh/functions/Completion/Unix.zwc
    #     /usr/share/zsh/functions/Zle.zwc

    filesp "$1" | awk 'NR > 1 {print $2}' | sort -u
}

extract() {
    # Handy shortcut stolen from internetz.
    # Extracts archives.

    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)  tar xvjf    "$1";;
            *.tar.gz)   tar xvzf    "$1";;
            *.tar.xz)   tar xvJf    "$1";;
            *.bz2)      bunzip2     "$1";;
            *.rar)      unrar x     "$1";;
            *.gz)       gunzip      "$1";;
            *.xz)       unxz        "$1";;
            *.tar)      tar xvf     "$1";;
            *.tbz2)     tar xvjf    "$1";;
            *.tgz)      tar xvzf    "$1";;
            *.zip)      unzip       "$1";;
            *.Z)        uncompress  "$1";;
            *.7z)       7z x        "$1";;
            *)          echo        "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

reswap() {
    sudo swapoff -a && sudo swapon -a
}

n() {
    HISTFILE=; PS1="inc> ";
}

k8s-pod-shell() {
    NAMESPACE=$1
    POD_NAME=$2
    SHELL=${*:3}
    if [[ $SHELL == "" ]]; then
        SHELL="sh"
    fi
    POD=`kubectl -n ${NAMESPACE} get pods | grep -m1 ${POD_NAME} | awk '{ print $1 }'`
    echo "Running ${SHELL} in ${POD}"
    kubectl -n ${NAMESPACE} exec -it ${POD} -- "$SHELL"
}

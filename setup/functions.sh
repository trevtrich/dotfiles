#!/bin/bash

DOTFILES_ROOT="$(pwd)/../"
DOTFILES_LINK="$HOME/.dotfiles"

. "$DOTFILES_LINK/bash/colors.sh"

heading() {
    printf "\n%s%s%s\n" "$YELLOW" "$1" "$RESET"
}

info() {
    printf "  [ %s..%s ] %s\n" "$BLUE" "$RESET" "$1"
}

success() {
    printf "  [ %sOK%s ] %s\n" "$GREEN" "$RESET" "$1"
}

warn() {
    printf "  [%sWARN%s] %s\n" "$ORANGE" "$RESET" "$1"
}

fail() {
    printf "  [%sFAIL%s] %s\n" "$RED" "$RESET" "$1"
    return 8
}

windows() { [[ -n "$WINDIR" ]]; }

is_symbolic_link() {
    local path=$1

    if windows; then
        fsutil reparsepoint query "${path}" > /dev/null
    else
        [[ -h ${path} ]]
    fi
}

create_link() {
    local link_target=$1
    local link_name=$2

    if windows; then
        link_target=${link_target/\/c\//c:\\}
        link_name=${link_name/\/c\//c:\\}

        # Windows needs to be told if it's a directory or not. Infer that.
        # Also: note that we convert `/` to `\`. In this case it's necessary.
        if [[ -d ${link_target} ]]; then
            cmd <<< "mklink /D \"${link_name//\//\\}\" \"${link_target//\//\\}\"" > /dev/null
        else
            cmd <<< "mklink \"${link_name//\//\\}\" \"${link_target//\//\\}\"" > /dev/null
        fi
    else
        ln -s "${link_target}" "${link_name}"
    fi

    success "linked ${link_target} to ${link_name}"
}

link_file() {
    local link_target=$1
    local link_name=$2

    # is a broken symbolic link
    if is_symbolic_link "${link_name}" && [[ ! -e ${link_name} ]]; then
        warn "Removing broken link for ${link_name}"
        rm "${link_name}"
    fi

    # is a symbolic link
    if is_symbolic_link "${link_name}"; then
        info "${link_name} already linked"
    # is a real file or directory
    elif [[ -f ${link_name} ]] || [[ -d ${link_name} ]]; then
        warn "${link_name} already exists"
    # safe to create symbolic link
    else
        create_link "${link_target}" "${link_name}"
    fi
}

link_dotfile() {
    local source=$1
    local filename
    filename=$(basename "${source}")
    local dest="$HOME/$filename"

    link_file "${source}" "${dest}"
}

link_dotfiles_directory() {
    link_file "${DOTFILES_ROOT}" "${DOTFILES_LINK}"
}

link_dotfiles() {
    local source;

    while IFS= read -r -d '' source
    do
        link_dotfile "${source}"
    done <   <(find "${DOTFILES_LINK}/" -mindepth 2 -maxdepth 2 -name '\.*' -not -path '*/.dotfiles//\.*' -not -path '*.DS_Store' -print0)
}

link_maven_extensions() {
    local source;
    local extension;

    if [[ -z $M2_HOME ]]; then
        warn "M2_HOME environment variable not set"
    else
        while IFS= read -r -d '' source
        do
            extension=$(basename "${source}")
            link_file "${source}" "$M2_HOME/lib/ext/${extension}"
        done <   <(find "${DOTFILES_LINK}/maven/extensions" -mindepth 1 -maxdepth 1 -print0)
    fi
}

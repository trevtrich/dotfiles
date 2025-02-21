# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # Block cursor in normal mode
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # Beam cursor in insert mode
  fi
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins  # Start in insert mode
}
zle -N zle-line-init

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^?' backward-delete-char

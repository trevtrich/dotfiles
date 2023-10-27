#!/bin/bash

NEWLINE=$'\n'

bracket_color="${WHITE}"
colon_color="${WHITE}"

prompt_color="${TARHEEL}"

if [[ "$SSH_TTY" ]]; then
  # connected via ssh
  prompt_color="${CYAN}"
elif [[ "$USER" == "root" ]]; then
  # logged in as root
  prompt_color="${PURPLE}"
fi

function prompt_git() {
  local git_status output flags

  git_status="$(git status 2>/dev/null)"

  # shellcheck disable=SC2181
  [[ $? != 0 ]] && return;

  output="$(echo "$git_status" | awk '/Initial commit/ {print "(init)"}')"

  [[ "$output" ]] || output="$(echo "$git_status" | awk '/On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"

  flags="$(
    echo "$git_status" | awk 'BEGIN {r=""}
      /^(# )?Unmerged paths:$/                 {r=r ENVIRON["CYAN"]"*"}
      /^(# )?Changes to be committed:$/        {r=r ENVIRON["GREEN"]"+"}
      /^(# )?Changes not staged for commit:$/  {r=r ENVIRON["RED"]"!"}
      /^(# )?Untracked files:$/                {r=r ENVIRON["ORANGE"]"?"}
      END {print r}'
  )"

  if [[ "$flags" ]]; then
    output="${output}${colon_color}:${prompt_color}${flags}"
  fi
  echo "${bracket_color}[${GREY_LIGHT}${output}${bracket_color}]${RESET}"
}

function prompt_virtualenv() {
  if [[ "$VIRTUAL_ENV" ]]; then
    echo "${bracket_color}[${CYAN}$(basename "$VIRTUAL_ENV")${bracket_color}]${RESET}"
  fi
}

# Exit code of previous command.
function prompt_exitcode() {
  local exitcode_color="${RED}"

  [[ $1 != 0 ]] && echo " ${exitcode_color}$1\[${RESET}\]"
}

function prompt_command() {
  local exit_code=$?

  PS1="${NEWLINE}"

  # open new tabs at cwd on OSX
  if type update_terminal_cwd > /dev/null 2>&1; then
    PS1="$PS1$(update_terminal_cwd)"
  fi

  # git: [branch:flags]
  PS1="$PS1$(prompt_git)"

  # path: [path]
  PS1="$PS1${bracket_color}[${prompt_color}$(basename $(dirname "$PWD"))/$(basename "$PWD")${prompt_color}${bracket_color}]${RESET}"
  PS1="$PS1$(prompt_virtualenv)"

  #PS1="$PS1\n"
  # date: [HH:MM:SS]
  #PS1="$PS1$bracket_color[$(date +"$prompt_color%H$colon_color:$prompt_color%M$colon_color:$prompt_color%S")$bracket_color]\[${RESET}\]"
  # exit code: 127
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  PS1="$PS1${NEWLINE}\$ "
}

precmd() { prompt_command }

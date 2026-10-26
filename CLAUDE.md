# CLAUDE.md

Personal dotfiles for one user (Trevor), currently on macOS (Apple Silicon, zsh). Linux (Ubuntu + Linuxbrew) is supported secondarily. Windows support has been removed. Bash config remains, but **zsh is the primary shell**.

There is no build, no test suite, and no CI.

## How it's wired

- The repo lives at `~/development/dotfiles` and is symlinked as **`~/.files`**. Every runtime path uses `~/.files/...`, never the repo path.
- A private companion repo, **`~/.files.extra`**, mirrors this layout (`zsh/source.sh`, `zsh/aliases.sh`, `zsh/secrets.sh`, `osx/Brewfile`, `vim/.vim/settings.vim`, `~/.gitconfig.extra`). It is optional and always guarded with `[ -e ... ]`. **Secrets and work-specific values go there, never in this repo.** Examples are tokens such as MAILOSAUR_API_KEY, FONTAWESOME_TOKEN, and SONAR_TOKEN.
- **Symlinking rule** (`setup/functions.sh` → `link_dotfiles`): any file or dir whose name starts with `.` and sits *exactly one level deep* in a topic dir (`zsh/.zshrc`, `vim/.vim`, `gpg/.gnupg`, `nvm/.nvm`, `ruby/.rbenv`, `tmux/.tmux.conf`, `git/.gitconfig`, `idea/.ideavimrc`, `code/.editorconfig`, etc.) gets linked into `$HOME`. Non-dot files (`*.sh`) are never linked. They are sourced by path from `~/.files/...`.
  - To add a new home dotfile, drop `topic/.name` into the repo and re-run setup option 1, or `ln -s ~/.files/topic/.name ~/.name` by hand.
  - Linking never overwrites. If a real file already exists at the target, it warns and skips.
- `osx/gitconfig.osx` is linked to `~/.gitconfig.os` and included by `git/.gitconfig`.

## Bootstrap (`setup/`)

```sh
cd setup && source init.sh     # interactive menu; or: source menu.sh <1|2|3>
```

- `init.sh` links the repo to `~/.files`, then runs `menu.sh`.
- Choice 1 runs `environment.sh`: `link_dotfiles`, `link_gitconfig_for_os`, creates `~/bin`, and runs `osx/environment.sh` (`defaults write` tweaks) or `linux/environment.sh`.
- Choice 2 runs `software.sh`, which calls `/bin/bash osx/software.sh` or `linux/software.sh`. These handle the Homebrew install, `brew bundle` on `osx/Brewfile` (plus the `.files.extra` Brewfile), upgrade, cleanup, and the `~/.nvm` scaffold.
- Choice 3 runs both.
- The scripts **must be sourced from inside `setup/`** because they use relative `../` paths and `$(pwd)/../`. They run under zsh.
- `software.sh` scripts use `set -euo pipefail`. On macOS, `brew doctor` only warns and does not abort. On Linux it still aborts (`|| exit 1`).
- They call `sudo -v` and perform real system changes. **Don't run setup scripts yourself.** Tell the user what to run.

## Shell startup order (zsh)

1. `zsh/.zprofile` runs `brew shellenv` and adds the JetBrains Toolbox to PATH. For **non-interactive** login shells only, it also sources `zsh/exports.sh`. Interactive shells skip that on purpose: `.zshrc` must load the nvm PATH *after* its own `brew shellenv`, so Homebrew's node doesn't shadow nvm's (see the comment in the file).
2. `zsh/.zshrc` runs `brew shellenv` again (OS-specific), then sources `zsh/source.sh`, then `~/.files.extra/zsh/source.sh`, then `input.sh`, `colors.sh`, and `prompt.sh`.
3. `zsh/source.sh` sources these in order: `colors`, `completion` (fzf + `osx/completion.sh`), `aliases` (+ `osx/aliases.sh`, + extra), `functions`, `exports`, `git/functions.sh`, `python/python-init.sh`, `prompt`, and `osx/source.sh`.
4. `zsh/exports.sh` sources `osx/exports.sh` and `linux/exports.sh`, sets EDITOR, DOCKER_HOST (colima), and VITEST_MAX_FORKS, then sources `~/.files.extra/zsh/secrets.sh`.

`bash/` mirrors this structure (`.bash_profile` → `bash/source.sh` → ...) and also sources `~/.cargo/env`. A zsh change does **not** automatically need a bash mirror. Only update bash if asked.

## Gotchas / invariants

- **Startup speed matters.** nvm and pyenv are lazy-loaded through stub functions (`nvm`/`node`/`npm`/`npx` in `osx/exports.sh`; `pyenv` in `python/python-init.sh`) because eager loading made startup take 10s+ (commit adbfb1ae). Don't add eager `eval "$(x init)"` calls or slow subshells to startup. Check with `time zsh -i -c exit`.
- **OS guards:** `osx/*.sh` files begin with `[[ "$OSTYPE" == darwin* ]] || return 1`, and `linux/*.sh` files sourced at startup begin with `[[ "$OSTYPE" == linux-* ]] || return 1`. Anything that should apply on both OSes, such as `~/bin` on PATH, belongs in `zsh/exports.sh`. nvm lazy-load stubs exist in both `osx/exports.sh` (hardcoded `/opt/homebrew`) and `linux/exports.sh` (`brew --prefix`), so change both together.
- Hardcoded paths are normal here: `/opt/homebrew`, `/Users/trevorr` (DOCKER_HOST, antigravity PATH). Some tools' installers append lines to `.zshrc`/`exports.sh` (for example "Added by Antigravity"/"Toolbox App"). Leave those lines alone unless asked.
- Vi-mode input: zsh uses ZLE (`zsh/input.sh`, `bindkey -M viins 'jk' vi-cmd-mode`), not readline. `bash/.inputrc` only affects bash.
- `.gitignore` excludes runtime contents of tracked dirs (`vim/.vim/plugged|autoload|bundle`, `nvm/.nvm/*` except `default-packages` and `alias/default`, `gpg/.gnupg/*` except the two confs, `ruby/.rbenv/versions|shims`). Because these dirs are symlinked into `$HOME`, tools write into the repo. Don't commit that output.
- `vim/.vim/colors/` holds ~500 vendored colorschemes. Ignore them when searching.

## Where things go

| Change | File |
|---|---|
| Homebrew package/cask/mas app (macOS) | `osx/Brewfile` (grouped by comment section; `mas` needs the App Store id) |
| Linux brew package / apt package | `linux/Brewfile` / `linux/software.sh` |
| Env var / PATH (cross-OS) | `zsh/exports.sh` |
| Env var / PATH (macOS-only) | `osx/exports.sh` |
| Alias | `zsh/aliases.sh` (`osx/aliases.sh` for mac-only) |
| Shell function | `zsh/functions.sh`; git helpers in `git/functions.sh` |
| Key bindings / vi mode | `zsh/input.sh` |
| Prompt | `zsh/prompt.sh` (+ `colors.sh`) |
| macOS `defaults write` | `osx/environment.sh` |
| Git config/aliases | `git/.gitconfig` (mac mergetool in `osx/gitconfig.osx`) |
| Vim | `vim/.vim/{plugins,settings,remap,autocmd}.vim` (vim-plug + coc) |
| tmux | `tmux/.tmux.conf` |
| Global node packages for new nvm installs | `nvm/.nvm/default-packages` |
| Secrets / employer-specific | `~/.files.extra/...` (not this repo) |

## Conventions

- Shell scripts start with a `#!/bin/zsh` (zsh/setup) or `#!/bin/bash` shebang, use 4-space indentation, and put `#shellcheck disable=SC1090` before dynamic `.` sources. Use `heading`/`info`/`success`/`warn`/`fail` from `setup/functions.sh` for setup output.
- To verify an edit: run `zsh -n <file>` for syntax, `zsh -i -c exit` to confirm a clean interactive startup, and `shellcheck <file>` if it's installed. Changes take effect after `reload` (`exec -l $SHELL`).
- Commits use Conventional Commits with an optional scope: `fix:`, `chore:`, `feat(tmux):`, `perf:`. Commits are GPG-signed (`commit.gpgsign = true`). This repo's default branch is **`master`**. The `.gitconfig` aliases `rom`, `dm`, and `pom` find the default branch through `git db` (origin/HEAD), so they work with both `main` and `master`.
- Integrate branches with merge, not rebase (user preference, and `pull.rebase = false`).

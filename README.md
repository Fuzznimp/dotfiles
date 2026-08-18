# Dotfiles

> Confused? Start here: https://dotfiles.github.io/

## Stack

- [zsh](https://www.zsh.org/): shell
- [tmux](https://github.com/tmux/tmux): terminal multiplexer
- [Ghostty](https://ghostty.org/): terminal emulator
- [atuin](https://atuin.sh/): shell history
- [fzf](https://github.com/junegunn/fzf): fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide): smarter `cd`
- [Zed](https://zed.dev/): primary editor
- [Neovim](https://neovim.io/): secondary editor
- [Raycast](https://www.raycast.com/): app launcher / productivity
- [Hammerspoon](https://www.hammerspoon.org/): macOS automation
- [lazygit](https://github.com/jesseduffield/lazygit): git TUI
- [gh-dash](https://github.com/dlvhdr/gh-dash): GitHub dashboard
- [rainfrog](https://github.com/achristmascarl/rainfrog): database TUI
- [superfile](https://github.com/yorukot/superfile): file manager TUI
- [yazi](https://github.com/sxyazi/yazi): file manager TUI
- [bat](https://github.com/sharkdp/bat): better `cat`
- [btop](https://github.com/aristocratos/btop): system monitor
- [eza](https://github.com/eza-community/eza): better `ls`
- [Homebrew](https://brew.sh/): packages (see `Brewfile`)

### Own tools

Go TUIs living in `$SCRIPTS_PATH`, cloned and built by `scripts/tools.sh`:

- [tmux-pane-manager](https://github.com/Fuzznimp/tmux-pane-manager): resize and swap tmux panes (`prefix + |`)
- [tmux-yoink](https://github.com/Fuzznimp/tmux-yoink): copy paths, URLs, JSON, commands out of the scrollback (`prefix + Y`, `prefix + F`)
- [tmux-gh-prs](https://github.com/Fuzznimp/tmux-gh-prs): PRs awaiting my review (`prefix + P`)
- [tmux-weather](https://github.com/Fuzznimp/tmux-weather): current conditions and 5-day forecast (`prefix + w`)
- [git-commit-wizard](https://github.com/Fuzznimp/git-commit-wizard): conventional commit composer (`gcm`)

---

## Bootstrap

On a fresh Mac, after cloning the repo:

```sh
./scripts/bootstrap.sh
```

It installs Homebrew and the `Brewfile`, stows the symlinks, then clones and
builds the own tools listed above. `gh auth login` first so the clones use ssh,
otherwise they fall back to https.

Rerunning is safe: `scripts/tools.sh` pulls and rebuilds existing checkouts.

---

## Symlinks

After spending more than two years handling symlinks myself, I wanted to find a tool that would help in that regard. I used [mackup](https://github.com/lra/mackup) for about a year, but wasn't really satisfied by it.
In the end, I got back to the roots, and I'm using [Stow](https://www.gnu.org/software/stow/).

From this repo:

```sh
# The `--no-folding` flag is used so that Zed's config hotreloading works correctly.
stow --no-folding . --target="$HOME/" --adopt
compaudit | xargs chmod g-w
```

---

## Archive

The `archive/` folder contains configs that are no longer in use but kept for reference.

---

## Notes

### Key repeat for Vim motions

To enable key repeat inside GUIs:

https://stackoverflow.com/questions/33152551/how-can-i-disable-applepressandholdenabled-for-a-specific-application-repeat

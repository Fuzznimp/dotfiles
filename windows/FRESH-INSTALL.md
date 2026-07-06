# Fresh Windows -> Dev Env

Rebuild WSL2 + Debian + dotfiles from scratch. Run top to bottom.

Env target: Windows 11 + WSL2 + Debian 13 (trixie) + linuxbrew + zsh + tmux. No GUI tools (see [Docker](#8-docker-optional)).

> Replace `monta` with your Windows username where it appears.

---

## 0. Windows side (do first)

- **Windows Terminal** — preinstalled on Win11. Else Microsoft Store.
- **Hack Nerd Font** — WT renders with a *Windows* font, not a Linux one. Download from <https://www.nerdfonts.com/font-downloads> (Hack), select all `.ttf`, right-click -> **Install for all users**.
- **Wallpaper** — WT `settings.json` points at `C:\Users\monta\Documents\wallpapers\background\hydra.png`. Create folder + drop image there, or edit the path later (source copy: `.config/ghostty/hydra.png` in this repo).
- **Developer Mode** (optional) — Settings -> System -> For developers. Only needed if you later want symlinks.

---

## 1. WSL2 + Debian

PowerShell (admin):

```powershell
wsl --install -d Debian
```

Reboot if prompted. First launch of Debian -> create UNIX user + password.

---

## 2. WSL config

Enable systemd (needed for Docker later, harmless otherwise). In Debian:

```bash
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true

[interop]
appendWindowsPath=true
EOF
```

Then from PowerShell: `wsl --shutdown` and reopen Debian.

---

## 3. Debian base packages + zsh

```bash
sudo apt update && sudo apt install -y build-essential procps curl file git zsh stow
```

Set zsh as login shell:

```bash
chsh -s "$(command -v zsh)"
```

Log out/in (close + reopen Debian tab) so zsh takes over.

---

## 4. Homebrew (linuxbrew)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

`.zprofile` already runs `brew shellenv` for `/home/linuxbrew/.linuxbrew` on Linux — no manual PATH edit needed once dotfiles are stowed (step 5). To use brew *before* stow, run the `eval` line the installer prints.

---

## 5. Dotfiles + stow

```bash
mkdir -p ~/workspace && git clone <YOUR_DOTFILES_REMOTE> ~/workspace/dotfiles
cd ~/workspace/dotfiles
stow --no-folding --adopt --target="$HOME" .
git restore .   # --adopt pulls existing files INTO repo; this reverts to repo versions
```

`--adopt` avoids "file exists" conflicts by absorbing stray defaults (`.bashrc` etc.), then `git restore .` throws that away, keeping the repo's tracked versions. `windows/` is in `.stow-local-ignore` -> not linked into `$HOME`.

Symlinks created: `.zshenv .zprofile .zshrc .gitconfig`, `zsh/*`, `.config/*`. Open a new shell.

---

## 6. Brew tools

⚠️ `brew bundle` will **fail on Linux** — the `Brewfile` has macOS `cask`/`mas` lines (ghostty, hammerspoon, 1password...). Install the Linux-relevant formulae directly:

```bash
brew install \
  atuin bat btop eza fd fzf gawk gh go gum htop jq luarocks ncdu neovim \
  ripgrep rustup sesh stow superfile television tldr tmux yazi yq zoxide \
  zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
  lazygit lazydocker rainfrog
```

Skip macOS-only ones: `colima`, `displayplacer`, `mas`, `cowsay` (opt). Some taps (`codeburn`, `xleak`, `tmux-snaglord`, `rtk`) — add per-tap if wanted.

---

## 7. Rust (rustup)

Homebrew's rustup is **keg-only** — no `~/.cargo/env`, shims live in `$HOMEBREW_PREFIX/opt/rustup/bin`, which `.zprofile` already adds to PATH. Just init a toolchain:

```bash
rustup default stable
```

Verify: `cargo --version && rustc --version`.

---

## 8. tmux plugins

Config uses TPM. XDG path (`XDG_CONFIG_HOME=$HOME/.config`):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Start tmux, then install plugins: **`ctrl+shift+r`** (= `prefix + I`).

> macOS-only plugins/scripts degrade quietly on Linux: `tmux-nowplaying-macos`, `colima-status`, `battery`. Status bar shows blanks — cosmetic.

---

## 9. Windows Terminal config

No symlink (cross-FS symlinks flaky). Keep repo + live in sync manually.

Deploy repo config to live location (from Debian):

```bash
cp -f ~/workspace/dotfiles/windows/windows-terminal/settings.json \
  "/mnt/c/Users/monta/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
```

Notes:
- **Ctrl = Cmd.** All tmux shortcuts are `sendInput` binds that type `prefix (0x02) + key`. Ctrl reclaimed from native EOF/suspend/clear/etc. by choice.
- Binds MUST live in the **`keybindings`** array. `keys` inside `actions` = **ignored** by this WT version -> keys fall through (e.g. `ctrl+d` = EOF, closes pane).
- Control bytes stored as JSON `\u` escapes (`0x02` = `C-b` prefix, `0x1b` = ESC, `0x19` = `C-y`). Raw bytes = invalid JSON.
- If binds don't apply after copy: fully **quit WT** (close all windows) and reopen — live reload doesn't always re-register `keybindings`.
- Update the `backgroundImage` path + Debian distro `guid` if they differ on the new box.

Sync direction going forward: edit repo -> `cp` to live, OR edit in WT -> `cp` live back to repo. Commit repo.

---

## 10. Docker (optional)

No Docker Desktop (GUI). WSL2 *is* a Linux VM -> run engine natively (Colima not needed, it'd nest a VM).

```bash
# Docker apt repo
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER"
```

systemd (step 2) auto-starts `dockerd`. Uses default `/var/run/docker.sock` -> leave `DOCKER_HOST` unset (`.zshrc` only sets Colima socket on macOS). New login -> `docker run hello-world`.

---

## 11. macOS-only leftovers (informational)

Live in the repo, inert or absent on Windows:
- `Brewfile` casks + `mas`, `.hammerspoon/`, `Library/`, `.config/ghostty` (WT used instead), `.config/raycast`.
- Colima references, `alt` word-jump binds tuned for macOS option key.
- Cross-platform seam: `$OS` set in `.zshenv` from `$OSTYPE`; `.zprofile`/`.zshrc` branch on it.

---

## Quick verify

```bash
echo $OS                       # linux
brew --version
cargo --version
tmux -V
exec zsh -l                    # no errors on startup
```

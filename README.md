# Dotfiles

If you are confused: https://dotfiles.github.io/.

## Specs:

- zsh
- Nvim
- tmux
- alacritty
- hammerspoon
- lf
- lazygit
- brew
- VSCode
- ..and many more!

## Symlinks

After spending more than two years handling symlinks myself, I wanted to find a tool that would help in that regard. I used [mackup](https://github.com/lra/mackup) for about a year, but wasn't really satisfied by it.
In the end, I got back to the roots, and I'm using [Stow](https://www.gnu.org/software/stow/).

From this repo:

```sh
stow . --target="$HOME/"
compaudit | xargs chmod g-w
```

## Key repeat for VimMotions inside cursor

https://stackoverflow.com/questions/33152551/how-can-i-disable-applepressandholdenabled-for-a-specific-application-repeat

## TODO:

### Global

- [ ] Automate `ApplePressAndHoldEnabled`.
- [ ] Add global theme object.
- [ ] Extract cspell hash to global level.
- [ ] .setup

### brew

- [ ] Add `brew.sh`. <!-- Install brew, then Brewfile. -->.

### OS

- [ ] Add `osx.sh`. <!-- Dock, shortcuts, etc. -->

### nvim

- [ ] Finish colorscheme.
- [ ] cmp and lsp keybinds

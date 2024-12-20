# Requirements

**tl;dr**:

```
$ curl https://mise.run | sh
$ mise trust && mise install
```

For tmux:

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

And inside a tmux session: `<C-a> + I` to install.

## Tools

- [Ripgrep](https://github.com/BurntSushi/ripgrep#installation)

  - **MacOS**:

  ```
  brew install Ripgrep
  ```

  - **Debian, or debian derived**:

  ```
  $ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
  $ sudo dpkg -i ripgrep_13.0.0_amd64.deb
  ```

- [fzf](https://github.com/junegunn/fzf)

  Used for `tmux-sessionizer` script.

  - **MacOS**:

  ```
  brew install fzf
  ```

- [Stow](https://www.gnu.org/software/stow/)

  `stow` is used to create the symlinks to the appropriate folders.

  - **MacOS**:

  ```
  brew install stow
  ```

- [fd](https://github.com/sharkdp/fd)

  `fd` is a faster alternative to `find`.

  - ** MacOS**:

  ```
  brew install fd
  ```

- [pngpaste](*https://github.com/jcsalterego/pngpaste)

  ```
  brew install pngpaste
  ```

`pipx`

## Usage

Just run `install.sh`, which will unstow and re-stow all files, or run `stow`:

- `stow -D <folder>` - unlinks folder
- `stow <folder>` - links the folder

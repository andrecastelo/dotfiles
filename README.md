# Requirements

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

  Stow is used to create the symlinks to the appropriate folders.

  - **MacOS**:

  ```
  brew install stow
  ```

## Usage

Just run `install.sh`, which will unstow and re-stow all files.

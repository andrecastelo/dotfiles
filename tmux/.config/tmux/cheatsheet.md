# Tmux Cheat sheet

| Key Binding | Description |
| ----------- | ----------- |
| `ctrl+a`    | prefix      |

## Plugin manager Bindings

| Binding                             | Description       |
| ----------------------------------- | ----------------- |
| `<prefix> + I` (capital I)          | install plugins   |
| `<prefix> + U` (capital U)          | updates plugins   |
| `<prefix> + alt + u` (lower case u) | uninstall plugins |

## Session Bindings

- Sessions are a collection of windows.
- Windows are like tabs in browsers, which is a collection of tab panes

| Key binding    | What it does            |
| -------------- | ----------------------- |
| `<prefix> + d` | Detaches from a session |
| `<prefix> + $` | Renames a session       |
| `<prefix> + s` | Lists all sessions      |

## Window Bindings

- Windows are like tabs in browsers, which is a collection of tab panes

| Key binding      | What it does                  |
| ---------------- | ----------------------------- |
| `<prefix> + c`   | New window                    |
| `<prefix> + <#>` | Switch to window number `#`   |
| `<prefix> + n`   | Switch to the next window     |
| `<prefix> + p`   | Switch to the previous window |
| `<prefix> + w`   | Lists all windows             |
| `<prefix> + ,`   | Renames current window        |
| `<prefix> + &`   | Kills current window          |

## Pane Bindings

| Key binding            | What it does             |
| ---------------------- | ------------------------ |
| `<prefix> + %`         | New vertical pane        |
| `<prefix> + "`         | New horizontal pane      |
| `<prefix> + x`         | Kills pane               |
| `<prefix> + arrow key` | Alternates between panes |
| `<prefix> + q`         | Easy switch of panes     |
| `<prefix> + z`         | Zoom on pane             |
| `<prefix> + !`         | Turn pane into window    |

## Commands

All of these commands are prefixed by `tmux`.

| Command                    | What it does                   |
| -------------------------- | ------------------------------ |
| `new`                      | Creates a new session          |
| `new -s <session name>`    | Creates a named session        |
| `attach -t <session name>` | Attaches to a specific session |
| `ls`                       | Lists open sessions            |

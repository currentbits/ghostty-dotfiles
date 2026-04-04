# Ghostty Dotfiles

Automated setup script for macOS Ghostty terminal with Oh My Zsh, Starship, tmux, and CLI utilities.

## Features

- **Terminal**: Ghostty with FiraCode Nerd Font Mono, custom padding and opacity
- **Shell**: Oh My Zsh with syntax highlighting, autosuggestions, and plugins
- **Prompt**: Starship with gruvbox_dark theme and comprehensive status segments
- **Multiplexer**: tmux with modern keybindings and status bar
- **CLI Tools**: fzf, fd, bat, eza, zoxide, thefuck, asdf

## Installation

1. Make sure [Homebrew](https://brew.sh/) is installed
2. Run the setup script:

```bash
./setup-dotfiles.sh
```

3. Restart Ghostty or press `Ctrl+Shift+R`

## Configuration Files

- `~/.zshrc` - Zsh configuration with Oh My Zsh plugins
- `~/.config/starship.toml` - Starship prompt theme
- `~/.config/ghostty/config` - Ghostty terminal settings
- `~/.tmux.conf` - tmux configuration

## Keybindings

### tmux
- `Ctrl+a` - prefix (instead of Ctrl+b)
- `Ctrl+a |` - split pane horizontally
- `Ctrl+a -` - split pane vertically
- `Ctrl+a r` - reload tmux config
- `Ctrl+a + Arrow keys` - switch panes (Left/Right/Up/Down)

### Aliases
- `cd <dir>` → zoxide (smart directory navigation)
- `cat <file>` → bat (syntax highlighted cat)
- `vim` → nvim

## Theme

Based on [falleco/dotfiles](https://github.com/falleco/dotfiles), adapted for Ghostty instead of WezTerm.

## License

MIT

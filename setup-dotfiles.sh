#!/bin/bash

# Setup script for Ghostty terminal with falleco/dotfiles configuration
# Includes Oh My Zsh, Starship, tmux, and all CLI utilities

set -e  # Exit on error

echo "🚀 Starting dotfiles setup..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install it first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "📦 Installing CLI utilities..."
brew install starship fzf fd bat eza zoxide thefuck asdf tmux

echo "🔌 Installing Oh My Zsh plugins..."
mkdir -p ~/.oh-my-zsh/custom/plugins

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

echo "🔤 Installing FiraCode Nerd Font..."
brew install --cask font-fira-code-nerd-font

echo "⚙️  Creating .zshrc configuration..."
cat > ~/.zshrc << 'EOF'
export PATH="$HOME/.local/bin:$PATH"
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTRHOPIC_API_KEY=""

export PATH="$HOME/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Which plugins would you like to load?
plugins=(
  git
  asdf
  fzf
  ansible
  kubectx
  kubectl
  nvm
  yarn
  npm
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Zoxide initialization
eval "$(zoxide init zsh)"

# Aliases
alias vim='nvim'
alias cat='bat'
alias cd='z'

# FZF configuration
export FZF_DEFAULT_OPTS='
--height 40%
--layout=reverse
--border
--color=bg+:#3c3836,bg:#282828,spinner:#fabd2f,hl:#fb4934
--color=fg:#ebdbb2,header:#fb4934,info:#8ec07c,pointer:#fb4934
--color=marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
'

# Starship initialization
eval "$(starship init zsh)"

# Thefuck alias
eval $(thefuck --alias)
EOF

echo "🎨 Creating starship.toml configuration..."
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
format = """
$os$username$directory$git_branch$git_status$c$rust$golang$nodejs$php$java$kotlin$haskell$python$docker_context$conda$time\
$character
"""

# --- Palettes (gruvbox_dark) ---
[palettes.gruvbox_dark]
bg0 = "#282828"
bg1 = "#3c3836"
bg2 = "#504945"
fg0 = "#fbf1c7"
fg4 = "#a89984"
red = "#fb4934"
green = "#b8bb26"
yellow = "#fabd2f"
blue = "#83a598"
purple = "#d3869b"
aqua = "#8ec07c"
orange = "#fe8019"

# --- Default palette ---
palette = "gruvbox_dark"

# --- OS ---
[os]
disabled = false
style = "bold fg4"
format = "[$symbol]($style) "

[os.symbols]
Macos = " "
Linux = " "
Windows = " "

# --- Username ---
[username]
show_always = false
style_user = "bold green"
format = "[$user]($style) "

# --- Directory ---
[directory]
style = "bold blue"
truncation_length = 3
truncate_to_repo = false

# --- Git branch ---
[git_branch]
symbol = " "
style = "bold purple"

# --- Git status ---
[git_status]
style = "bold red"
format = '([\[$all_status$ahead_behind\]]($style))'

conflicted = "⚔️ "
ahead = "⇡"
behind = "⇣"
diverged = "⇕"
untracked = "?"
stashed = "📦"
modified = "!"
staged = "+"
renamed = "»"
deleted = "✘"

# --- C ---
[c]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Rust ---
[rust]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Go ---
[golang]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Node.js ---
[nodejs]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- PHP ---
[php]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Java ---
[java]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Kotlin ---
[kotlin]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Haskell ---
[haskell]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Python ---
[python]
symbol = " "
format = "[$symbol ($version)]($style) "

# --- Docker ---
[docker_context]
symbol = " "
format = "[$symbol ($context)]($style) "

# --- Conda ---
[conda]
symbol = " "
format = "[$symbol ($environment)]($style) "

# --- Time ---
[time]
disabled = false
format = "[ $time]($style) "
style = "bold fg4"
time_format = "%R"

# --- Character ---
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"
EOF

echo "🖥️  Creating Ghostty configuration..."
mkdir -p ~/.config/ghostty
cat > ~/.config/ghostty/config << 'EOF'
# Font configuration
font-family = FiraCode Nerd Font Mono
font-size = 15

# Window padding (30px all sides)
window-padding-x = 30
window-padding-y = 30

# Background opacity (0.9 like WezTerm)
background-opacity = 0.9

# Cursor color matching WezTerm (#A6ACCD light blue)
cursor-color = #A6ACCD
cursor-style = block

# Window decorations
window-decoration = none

# Poimandres-like colors
background = #232136
foreground = #e0def4

# Scrollback
scrollback-limit = 10000

# Keybinding to reload configuration
keybind = ctrl+shift+r=reload_config
EOF

echo "📟 Creating tmux configuration..."
cat > ~/.tmux.conf << 'EOF'
# Remap prefix from Ctrl-b to Ctrl-a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config
bind r source-file ~/.tmux.conf \; display "Reloaded config!"

# Switch panes using Alt-arrow keys
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Enable mouse mode
set -g mouse on

# Set base index to 1
set -g base-index 1
set -w pane-base-index 1

# Set terminal colors
set -g default-terminal "screen-256color"

# Status bar customization
set -g status-bg colour234
set -g status-fg colour136
set -g status-interval 60
set -g status-left-length 30
set -g status-left '#[fg=green,bold]#[fg=white] #S #[fg=green]#[fg=white] #I '
set -g status-right '#[fg=green]%H:%M #[fg=white]%a %d-%b-%y'

# Window status
set -g window-status-format '#[fg=colour233,bg=colour245] #I #[fg=colour233,bg=colour245] #W '
set -g window-status-current-format '#[fg=colour233,bg=colour39] #I #[fg=colour233,bg=colour39] #W* '

# Pane borders
set -g pane-border-style 'fg=colour238 bg=colour235'
set -g pane-active-border-style 'fg=green bg=colour236'
EOF

echo ""
echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Restart Ghostty or press Ctrl+Shift+R to reload"
echo "   2. Start tmux with: tmux"
echo "   3. Use tmux prefix: Ctrl+a (instead of Ctrl+b)"
echo ""
echo "🎨 Useful aliases:"
echo "   cd <dir>     → zoxide (smart directory navigation)"
echo "   cat <file>    → bat (syntax highlighted cat)"
echo "   vim            → nvim"
echo ""
echo "📊 Tools installed:"
echo "   - starship (prompt)"
echo "   - fzf (fuzzy finder)"
echo "   - fd (fast find)"
echo "   - bat (better cat)"
echo "   - eza (better ls)"
echo "   - zoxide (smart cd)"
echo "   - thefuck (command correction)"
echo "   - asdf (version manager)"
echo "   - tmux (terminal multiplexer)"
EOF

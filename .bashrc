# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
eval "$(starship init bash)"

# Mostrar neofetch solo si es una terminal interactiva y no dentro de tmux/nested shells
if [[ $- == *i* ]] && [[ ! $NEOFETCH_SHOWN ]]; then
    neofetch
    export NEOFETCH_SHOWN=1
fi

export PATH=$PATH:/home/alejandro/.spicetify
. "$HOME/.cargo/env"

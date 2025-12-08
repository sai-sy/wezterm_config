# Wezterm Config

For Windows 11 and WSL2 Ubuntu

## Setup

```bash
git clone git@github.com:sai-sy/wezterm_config.git # clone repo
mv wezterm_config /mnt/c/Users/saiha/.config/. # put in spot
mv /mnt/c/Users/saiha/.config/wezterm/wezterm_config /mnt/c/Users/saiha/.config/wezterm/wezterm # rename to wezterm
```
To get new tabs opening in cwd add `PROMPT_COMMAND='printf "\e]7;file://%s%s\e\\" "$HOSTNAME" "$PWD"; '"$PROMPT_COMMAND"` to your `~/./bashrc`

```cat <<'EOF' >> ~/.bashrc
PROMPT_COMMAND='printf "\e]7;file://%s%s\e\\" "$HOSTNAME" "$PWD"; '"$PROMPT_COMMAND"
EOF
```


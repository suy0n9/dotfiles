#!/bin/bash

BASE="$(cd "$(dirname "${0}")/.." && pwd)"
REPO_CONFIG=$BASE/.config

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [ ! -f "${HOME}"/.zshenv ]; then
  ln -sfv "${REPO_CONFIG}/zsh/.zshenv" "$HOME/.zshenv"
fi

if [ ! -f "${XDG_CONFIG_HOME}/zsh/.zshrc" ]; then
  mkdir -p "${XDG_CONFIG_HOME}/zsh"
  ln -sfv "${REPO_CONFIG}/zsh/.zshrc" "${XDG_CONFIG_HOME}/zsh/.zshrc"
fi

if [ ! -d "${XDG_CONFIG_HOME}/zsh/_zsh" ]; then
  ln -sfv "${BASE}/zsh/" "${XDG_CONFIG_HOME}/zsh/_zsh"
fi

if [ ! -f "${XDG_CONFIG_HOME}/peco/config.json" ]; then
  mkdir -p "${XDG_CONFIG_HOME}/peco"
  ln -sfv "${REPO_CONFIG}/peco/config.json" "${XDG_CONFIG_HOME}/peco/config.json"
fi

if [ ! -f "${XDG_CONFIG_HOME}/starship.toml" ]; then
  ln -sfv "${REPO_CONFIG}/starship.toml" "${XDG_CONFIG_HOME}/starship.toml"
fi

if [ ! -f "${HOME}/.vim/vimrc" ]; then
  ln -sfv "${BASE}/vim/vimrc" "${HOME}/.vim/vimrc"
fi

if [ ! -d "${HOME}/.vim/_config" ]; then
  ln -sfv "${BASE}/vim/_config" "${HOME}/.vim/_config"
fi

if [ ! -f "${XDG_CONFIG_HOME}/lazygit/config.yml" ]; then
  mkdir -p "${XDG_CONFIG_HOME}/lazygit"
  ln -sfv "${REPO_CONFIG}/lazygit/config.yml" "${XDG_CONFIG_HOME}/lazygit/config.yml"
fi

if [ ! -d "${XDG_CONFIG_HOME}/git" ]; then
  ln -sfv "${REPO_CONFIG}/git" "${XDG_CONFIG_HOME}/git"
fi

if [ ! -d "${XDG_CONFIG_HOME}/tmux" ]; then
  ln -sfv "${REPO_CONFIG}/tmux" "${XDG_CONFIG_HOME}/tmux"
fi

if [ ! -d "${XDG_CONFIG_HOME}/asdf" ]; then
  ln -sfv "${REPO_CONFIG}/asdf" "${XDG_CONFIG_HOME}/asdf"
fi

if [ ! -f "${XDG_CONFIG_HOME}/pypoetry/config.toml" ]; then
  mkdir -p "${XDG_CONFIG_HOME}/pypoetry"
  ln -sfv "${REPO_CONFIG}/pypoetry/config.toml" "${XDG_CONFIG_HOME}/pypoetry/config.toml"
fi

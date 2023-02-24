#!/bin/bash

BASE=$(cd $(dirname ${0}) && pwd)

if [ ! -f ${HOME}/.config/peco/config.json ]; then
  mkdir -p ${HOME}/.config/peco
  ln -sfv ${BASE}/.config/peco/config.json ${HOME}/.config/peco/config.json
fi

if [ ! -f ${HOME}/.config/starship.toml ]; then
  ln -sfv ${BASE}/.config/starship.toml ${HOME}/.config/starship.toml
fi

if [ ! -d ${HOME}/.tmux/bin ]; then
  ln -sfv ${BASE}/.tmux/bin ${HOME}/.tmux
fi

if [ ! -d ${HOME}/.vim/_config ]; then
  ln -sfv ${BASE}/vim/_config ${HOME}/.vim/_config
fi

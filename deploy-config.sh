#!/bin/bash

BASE=$(cd $(dirname ${0}) && pwd)

if [ ! -f ${HOME}/.config/peco/config.json ]; then
  mkdir -p ${HOME}/.config/peco
  ln -sfv ${BASE}/.config/peco/config.json ${HOME}/.config/peco/config.json
fi

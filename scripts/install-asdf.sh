#!/bin/bash

plugins=(
  'python'
  'nodejs'
  'terraform'
)

for plugin in "${plugins[@]}"
do
  asdf plugin add "${plugin}"
  if [ $? -eq 2 ]; then
    continue
  fi

  asdf install "${plugin}" latest
  asdf global "${plugin}" latest
done

echo "$(tput setaf 2)Install asdf plugins complete. ✔︎$(tput sgr0)"

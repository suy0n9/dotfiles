#!/bin/sh

echo 'Start setup'
cd ~

echo '************ generate keypair?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    ssh-keygen ;;
  * ) echo "generate keypair skip" ;;
esac

echo '************ clone mac_setup?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    git clone https://github.com/suy0ng/mac_setup.git ;;
  * ) echo "clone mac_setup skip" ;;
esac

echo '************ install homebrew?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ;;
  * ) echo "install homebrew skip" ;;
esac

echo '************ install ansible?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    brew install python
    brew install ansible
    rehash ;;
  * ) echo "************ install ansible skip" ;;
esac

echo '************ run ansible?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    cd ~/mac_setup
    ansible-playbook -i hosts -vv localhost.yml ;;
  * ) echo "run ansible skip" ;;
esac

echo '************ setup dotfiles?[Y/n]'
read ANSWER
case $ANSWER in
  "" | "Y" | "y" )
    cd ~/mac_setup/dotfiles
    ./symlink.sh ;;
  * ) echo "setup dotfiles skip" ;;
esac

echo 'new Mac setup finished!! Please run "chsh -s /bin/zsh" & "exec $SHELL -l"'
#!/usr/bin/env bash

# Install nano editor https://www.nano-editor.org/dist/v4/nano-4.9.3.tar.xz Modified: 2020 May 23

VERSION="4.9.3"
NANO_SHORT="nano-$VERSION"
NANO_SRC="$NANO_SHORT.tar.xz"
NANO_URL="https://www.nano-editor.org/dist/v4"
NANO_EXTRA="https://github.com/scopatz/nanorc"


cd ~/
wget $NANO_URL/$NANO_SRC
tar -zxvf $NANO_SRC

mv $NANO_SHORT .nano && cd .nano/
./configure && make && sudo make install

git clone --depth=1 $NANO_EXTRA syntax_improved
cd ~/ && touch .nanorc

echo "# Enable syntax highlighting in Nano" >> $HOME/.nanorc
echo "include ~/.nano/syntax/*.nanorc" >> $HOME/.nanorc
echo "include ~/.nano/syntax_improved/*.nanorc" >> $HOME/.nanorc

rm -vf $NANO_SRC
printf "\nExit terminal and reopen using $NANO_SHORT\nTo unistall it and revert
to old:\ncd ~/.nano && sudo make\n"
exit

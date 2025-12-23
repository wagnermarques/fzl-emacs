#!/bash
sudo mkdir -p /usr/local/share/fonts/NerdFonts
wget -O /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
sudo unzip -o -j /tmp/FiraCode.zip -d /usr/local/share/fonts/NerdFonts
ls -lh /usr/local/share/fonts/NerdFonts
fc-cache -fv

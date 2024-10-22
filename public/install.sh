# add package repos

echo "adding vscodium key & repo"
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg arch=amd64] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

echo
## nodejs
"adding nodejs package repo"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -

echo
## pnpm
echo "intalling pnpm"

curl -fsSL https://get.pnpm.io/install.sh | sh -

## discord
echo "[signed-by=/usr/share/keyrings/discord-benni.gpg.asc] https://discord-apt.bendaha.eu.org/debian/ ./" | sudo tee /etc/apt/sources.list.d/discord.list
sudo wget -O /usr/share/keyrings/discord-benni.gpg.asc https://discord-apt.bendaha.eu.org/discord-benni.gpg.asc

## ytmdesktop
YTMDESKTOPLATEST=`curl -s https://api.github.com/repos/ytmdesktop/ytmdesktop/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`

curl -s https://api.github.com/repos/VSCodium/vscodium/releases/latest \
  | grep browser_download_url \
  | grep 'amd64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl --fail -L -o /tmp/youtube-music-desktop-app_$LATEST\_amd64.deb \
   ||  { echo "Failed to download amd64 deb"; exit 1; }

## installing 

sudo apt update && sudo apt install nodejs git curl codium discord -y
sudo gdebi /tmp/youtube-music-desktop-app_$LATEST\_amd64.deb

## setup fonts
wget -O /tmp/JetBrainsMono-2.304.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
wget -O /tmp/Inter-4.0.zip https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip

mkdir /home/benjamin/.fonts/JetbrainsMono
mkdir /home/benjamin/.fonts/Inter
unzip /tmp/JetBrainsMono-2.304.zip -d /home/benjamin/.fonts/JetbrainsMono
unzip /tmp/Inter-4.0.zip -d /home/benjamin/.fonts/Inter
cd ~/.dotfiles

# Append to .bashrc
echo "[[ -f ~/.bashrcdecoupled ]] && . ~/.bashrcdecoupled" >> ~/.bashrc

# stow dotfiles
sudo pacman -S stow --noconfirm --needed
stow .

# install dependencies
# pacman -Qent | cut -d ' ' -f 1 > dependencies.txt
sudo pacman -S --needed --noconfirm < dependencies.txt

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# install aur dependencies
# pacman -Qemt | cut -d ' ' -f 1 > aur-dependencies.txt
yay -S --needed --noconfirm < aur-dependencies.txt

# install nvm and node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install stable
nvm use stable

# install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# install bun
curl -fsSL https://bun.sh/install | bash

# set up docker user
sudo usermod -aG docker $USER

cd ~/.dotfiles

# Append to .bashrc
echo "[[ -f ~/.bashrcdecoupled ]] && . ~/.bashrcdecoupled" >> ~/.bashrc

# stow dotfiles
echo "Installing stow"
sudo pacman -S stow --noconfirm --needed
echo "Stowing dotfiles"
stow .

# install dependencies
# pacman -Qent | cut -d ' ' -f 1 > dependencies.txt
echo "Installing arch linux dependencies"
sudo pacman -S --needed --noconfirm < dependencies.txt

# install yay
echo "Installing yay (AUR helper)"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# install aur dependencies
# pacman -Qemt | cut -d ' ' -f 1 > aur-dependencies.txt
echo "Installing AUR dependencies"
yay -S --needed --noconfirm < aur-dependencies.txt

# install nvm and node.js
echo "Installing nvm and node.js"
if [ which nvm ]; then
    echo "nvm is already installed"
else
    echo "nvm is not installed, installing"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi
\. "$HOME/.nvm/nvm.sh"
nvm install stable
nvm use stable

# install pnpm
if [ which pnpm ]; then
    echo "pnpm is already installed"
else
    echo "pnpm is not installed, installing"
    curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# install bun
if [ which bun ]; then
    echo "bun is already installed"
else
    echo "bun is not installed, installing"
    curl -fsSL https://bun.sh/install | bash
fi

# set up docker user
echo "Adding user to docker group"
sudo usermod -aG docker $USER

# set up keyboard layout (fr azerty + arabic with alt+shift toggle)
echo "Setting up keyboard layout"
sudo echo "Section \"InputClass\"
        Identifier \"system-keyboard\"
        MatchIsKeyboard \"on\"
        Option \"XkbLayout\" \"fr,ar\"
        Option \"XkbOptions\" \"grp:alt_shift_toggle\"
	EndSection
	" > /etc/X11/xorg.conf.d/00-keyboard.conf

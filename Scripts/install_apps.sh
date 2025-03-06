#!/bin/bash
sudo apt install apt-transport-https wget curl gpg software-properties-common ca-certificates gnupg2 -y

#chrome
sudo wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list

#vscode
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list



# List of packages
packages=(
    build-essential
    cmake
    cmake-extras
    curl
    jq
    pkg-config
    parallel
    pipx
    psmisc
    scdoc
    xz-utils
    ark
    dolphin
    dolphin-plugins
    kitty
    rofi
    swayidle
    wlogout
    waybar
    wayland-protocols
    xwayland
    pipewire
    pipewire-alsa
    pipewire-audio
    pipewire-jack
    pipewire-pulse
    pavucontrol
    pamixer
    ffmpegthumbs
    imagemagick
    swappy
    git
    golang
    gawk
    gettext
    meson
    python3-mako
    python3-markdown
    python3-markupsafe
    python3-yaml
    qt5ct
    qt5-style-kvantum
    qt6-base-dev
    qt6-image-formats-plugins
    qt6-wayland
    qt6ct
    blueman
    bluez
    brightnessctl
    cliphist
    dunst
    eza
    fastfetch
    nwg-look
    neofetch
    lsd
    hyprland
    network-manager
    network-manager-gnome
    hwdata
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    libnotify-bin
    libstartup-notification0
    polkit-kde-agent-1
    seatd
    libpam0g-dev
    libtiffxx6
    vim
    zsh
    slurp
    grim
    wireplumber
    code 
    git 
    google-chrome-stable
    krusader
    ffmpeg
    nala
    zsh
)

# Remove duplicates
unique_packages=($(echo "${packages[@]}" | tr ' ' '\n' | sort -u))

# Install packages
echo "Installing packages..."
for pkg in "${unique_packages[@]}"; do
    if ! apt install -y "$pkg"; then
        echo -e "\033[0;31m[error]\033[0m Failed to install $pkg. Skipping..."
    else
        echo -e "\033[0;32m[success]\033[0m Successfully installed $pkg."
    fi
done

sudo pipx install --global hyprshade
pipx ensurepath
echo "Installation complete!"


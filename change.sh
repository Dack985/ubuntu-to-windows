#!/bin/bash

# Update package lists
sudo apt update

# Install KDE Plasma Desktop alongside GNOME
sudo apt install -y kde-plasma-desktop

# Install required tools for theme application
sudo apt install -y wget gnome-tweaks

# Download and install Windows 10 GTK theme for KDE Plasma
wget -O Windows-10-Dark.tar.gz "https://github.com/B00merang-Project/Windows-10/releases/download/1.1/Windows-10-Dark.tar.gz"
mkdir -p ~/.local/share/plasma/look-and-feel/
tar -xzf Windows-10-Dark.tar.gz -C ~/.local/share/plasma/look-and-feel/

# Download and install Windows icon theme
wget -O windows-10-icons.tar.gz "https://github.com/B00merang-Project/Windows-10-Icons/releases/download/1.0/windows-10-icons.tar.gz"
mkdir -p ~/.local/share/icons/
tar -xzf windows-10-icons.tar.gz -C ~/.local/share/icons/

# Download and install Windows cursor theme
wget -O windows-10-cursors.tar.gz "https://github.com/B00merang-Project/Windows-10-Cursors/releases/download/1.0/windows-10-cursors.tar.gz"
mkdir -p ~/.local/share/icons/
tar -xzf windows-10-cursors.tar.gz -C ~/.local/share/icons/

# Update GTK and icon theme settings for GNOME
gsettings set org.gnome.desktop.interface gtk-theme "Windows-10-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Windows-10-Icons"
gsettings set org.gnome.desktop.interface cursor-theme "Windows-10-Cursors"

# Log out the user and restart the display manager
if command -v gnome-session-quit &> /dev/null
then
    echo "Logging out..."
    gnome-session-quit --logout --no-prompt
else
    echo "gnome-session-quit not found, attempting to restart the display manager directly."
    # Restart the display manager (choose the appropriate one)
    sudo systemctl restart gdm3 || sudo systemctl restart sddm || sudo systemctl restart lightdm
fi

# Message to notify user
echo "KDE Plasma and Windows-like themes have been installed. You should see KDE Plasma as an option at the login screen."

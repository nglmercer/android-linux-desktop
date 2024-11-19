#!/bin/sh

# Function to show farewell message
goodbye() {
    echo -e "\e[1;31m[!] Something went wrong. Exiting...\e[0m"
    exit 1
}

# Function to show progress message
progress() {
    echo -e "\e[1;36m[+] $1\e[0m"
}

# Function to show success message
success() {
    echo -e "\e[1;32m[✓] $1\e[0m"
}

# Function to download file with skip option
download_file() {
    local download_path="$1"
    local filename="$2"
    local download_url="$3"

    if [ -e "$download_path/$filename" ]; then
        echo -e "\e[1;33m[!] File already exists: $filename\e[0m"
        echo -e "\e[1;33m[!] Skipping download...\e[0m"
        return 0
    fi

    progress "Downloading file..."
    wget -O "$download_path/$filename" "$download_url"
    if [ $? -eq 0 ]; then
        success "File downloaded successfully: $filename"
    else
        echo -e "\e[1;31m[!] Error downloading file: $filename. Exiting...\e[0m"
        goodbye
    fi
}

# Function to extract file with skip option
extract_file() {
    local extract_path="$1"
    local filename="$2"
    local target_dir="${filename%.tar.gz}"

    if [ -d "$extract_path/$target_dir" ]; then
        echo -e "\e[1;33m[!] Directory already exists: $extract_path/$target_dir\e[0m"
        return 0
    fi

    progress "Extracting file..."
    tar xpvf "$extract_path/$filename" -C "$extract_path" --numeric-owner >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        success "File extracted successfully: $extract_path/$target_dir"
    else
        echo -e "\e[1;31m[!] Error extracting file. Exiting...\e[0m"
        goodbye
    fi
}

# Function to download and execute script with skip option
download_and_execute_script() {
    local script_path="/data/local/tmp/start_debian.sh"
    local script_url="https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/start_debian.sh"

    if [ -e "$script_path" ]; then
        echo -e "\e[1;33m[!] Script already exists: $script_path\e[0m"
        return 0
    fi

    progress "Downloading script..."
    wget -O "$script_path" "$script_url"
    if [ $? -eq 0 ]; then
        success "Script downloaded successfully: $script_path"
        progress "Setting script permissions..."
        chmod +x "$script_path"
        success "Script permissions set"
    else
        echo -e "\e[1;31m[!] Error downloading script. Exiting...\e[0m"
        goodbye
    fi
}

# Main menu function
main_menu() {
    while true; do
        echo -e "\e[1;36m[+] Debian Chroot Installation Menu:\e[0m"
        echo "1. Download and Extract Debian Chroot"
        echo "2. Configure Debian Chroot Environment"
        echo "3. Start Debian Chroot"
        echo "4. Exit"
        echo -n "Enter your choice (1-4): "
        read CHOICE

        case $CHOICE in
            1)
                download_dir="/data/local/tmp/chrootDebian"
                if [ ! -d "$download_dir" ]; then
                    mkdir -p "$download_dir"
                    success "Created directory: $download_dir"
                fi
                
                download_file "$download_dir" "debian12-arm64.tar.gz" "https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz"
                extract_file "$download_dir" "debian12-arm64.tar.gz"
                download_and_execute_script
                ;;
            2)
                configure_debian_chroot
                ;;
            3)
                # Modify this path if necessary
                /data/local/tmp/start_debian.sh
                ;;
            4)
                exit 0
                ;;
            *)
                echo -e "\e[1;31m[!] Invalid option. Please try again.\e[0m"
                ;;
        esac
    fi
}

# ASCII art
echo -e "\e[32m"
cat << "EOF"
___  ____ ____ _ ___  _  _ ____ ____ ___ ____ ____    ____ _  _ ____ ____ ____ ___ 
|  \ |__/ |  | | |  \ |\/| |__| [__   |  |___ |__/    |    |__| |__/ |  | |  |  |  
|__/ |  \ |__| | |__/ |  | |  | ___]  |  |___ |  \    |___ |  | |  \ |__| |__|  |  
                                                                                   
EOF
echo -e "\e[0m"

# Check for root
if [ "$(whoami)" != "root" ]; then
    echo -e "\e[1;31m[!] This script must be run as root. Exiting...\e[0m"
    exit 1
fi

# Call the main menu
main_menu
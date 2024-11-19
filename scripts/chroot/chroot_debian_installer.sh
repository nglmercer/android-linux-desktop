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

extract_file() {
    local extract_path="$1"
    local filename="$2"
    local force="${3:-false}"
    local target_dir="${filename%.tar.gz}"

    if [ -d "$extract_path/$target_dir" ] && [ "$force" = "false" ]; then
        echo -e "\e[1;33m[!] Directory already exists: $extract_path/$target_dir\e[0m"
        echo -e "\e[1;33m[!] Use 'force' parameter to overwrite.\e[0m"
        return 0
    fi

    # If force is true, remove existing directory
    if [ "$force" = "true" ]; then
        rm -rf "$extract_path/$target_dir"
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

# Updated download_and_execute_script function
download_and_execute_script() {
    local script_path="/data/local/tmp/start_debian.sh"
    local script_url="https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/chroot/debian/start_debian.sh"
    local force="${1:-false}"

    if [ -e "$script_path" ] && [ "$force" = "false" ]; then
        echo -e "\e[1;33m[!] Script already exists: $script_path\e[0m"
        echo -e "\e[1;33m[!] Executing existing script...\e[0m"
        chmod +x "$script_path"
        "$script_path"
        return 0
    fi

    # If force is true, remove existing script
    if [ "$force" = "true" ]; then
        rm -f "$script_path"
    fi

    progress "Downloading script..."
    wget -O "$script_path" "$script_url"
    if [ $? -eq 0 ]; then
        success "Script downloaded successfully: $script_path"
        progress "Setting script permissions..."
        chmod +x "$script_path"
        success "Script permissions set"
        "$script_path"
    else
        echo -e "\e[1;31m[!] Error downloading script. Exiting...\e[0m"
        goodbye
    fi
}
# Function to configure Debian chroot environment
configure_debian_chroot() {
    progress "Configuring Debian chroot environment..."
    DEBIANPATH="/data/local/tmp/chrootDebian"

    # Check and create directory only if it doesn't exist
    if [ ! -d "$DEBIANPATH" ]; then
        mkdir -p "$DEBIANPATH"
        if [ $? -eq 0 ]; then
            success "Created directory: $DEBIANPATH"
        else
            echo -e "\e[1;31m[!] Error creating directory: $DEBIANPATH. Exiting...\e[0m"
            goodbye
        fi
    else
        echo -e "\e[1;33m[!] Directory already exists: $DEBIANPATH\e[0m"
        echo -e "\e[1;33m[!] Reusing existing directory...\e[0m"
    fi

    # Rest of the function remains the same...
    # (previous mount commands and configuration steps)
}

# Remaining functions (install_xfce4, install_kde, etc.) stay the same

# Main function
main() {
    if [ "$(whoami)" != "root" ]; then
        echo -e "\e[1;31m[!] This script must be run as root. Exiting...\e[0m"
        goodbye
    else
        download_dir="/data/local/tmp/chrootDebian"
        if [ ! -d "$download_dir" ]; then
            mkdir -p "$download_dir"
            success "Created directory: $download_dir"
        fi
        
        download_file "$download_dir" "debian12-arm64.tar.gz" "https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz"
        extract_file "$download_dir" "debian12-arm64.tar.gz" # default behavior        download_and_execute_script
        configure_debian_chroot
        modify_startfile_with_username
    fi
}

# Call the main function with ASCII art
echo -e "\e[32m"
cat << "EOF"
___  ____ ____ _ ___  _  _ ____ ____ ___ ____ ____    ____ _  _ ____ ____ ____ ___ 
|  \ |__/ |  | | |  \ |\/| |__| [__   |  |___ |__/    |    |__| |__/ |  | |  |  |  
|__/ |  \ |__| | |__/ |  | |  | ___]  |  |___ |  \    |___ |  | |  \ |__| |__|  |  
                                                                                   
EOF
echo -e "\e[0m"

main
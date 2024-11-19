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
        echo -e "\e[1;33m[!] Skipping extraction...\e[0m"
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
        echo -e "\e[1;33m[!] Skipping download...\e[0m"
    else
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
    fi

    progress "Executing script..."
    "$script_path"
    if [ $? -eq 0 ]; then
        success "Script executed successfully."
    else
        echo -e "\e[1;31m[!] Error executing script. Exiting...\e[0m"
        goodbye
    fi
}

# Main function
main() {
    if [ "$(whoami)" != "root" ]; then
        echo -e "\e[1;31m[!] This script must be run as root. Exiting...\e[0m"
        goodbye
    fi

    download_dir="/data/local/tmp/chrootDebian"
    if [ ! -d "$download_dir" ]; then
        mkdir -p "$download_dir"
        success "Created directory: $download_dir"
    fi

    while true; do
        echo -e "\e[1;36m\nChoose an option:\e[0m"
        echo "1) Extract and execute script"
        echo "2) Execute script directly"
        echo "3) Exit"
        read -p "Enter your choice: " choice

        case $choice in
        1)
            download_file "$download_dir" "debian12-arm64.tar.gz" "https://github.com/LinuxDroidMaster/Termux-Desktops/releases/download/Debian/debian12-arm64.tar.gz"
            extract_file "$download_dir" "debian12-arm64.tar.gz"
            download_and_execute_script
            ;;
        2)
            download_and_execute_script
            ;;
        3)
            echo -e "\e[1;31m[!] Exiting...\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31m[!] Invalid choice. Please try again.\e[0m"
            ;;
        esac
    done
}

# Call the main function
main

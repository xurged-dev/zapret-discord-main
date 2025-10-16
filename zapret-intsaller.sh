#!/bin/bash

# ====== ASCII ART ======
echo -e "\e[36m"
cat << 'EOF'
▒███████▒ ▄▄▄       ██▓███   ██▀███  ▓█████▄▄▄█████▓   ▒██   ██▒ █    ██  ██▀███  
▒ ▒ ▒ ▄▀░▒████▄    ▓██░  ██▒▓██ ▒ ██▒▓█   ▀▓  ██▒ ▓▒   ▒▒ █ █ ▒░ ██  ▓██▒▓██ ▒ ██▒
░ ▒ ▄▀▒░ ▒██  ▀█▄  ▓██░ ██▓▒▓██ ░▄█ ▒▒███  ▒ ▓██░ ▒░   ░░  █   ░▓██  ▒██░▓██ ░▄█ ▒
  ▄▀▒   ░░██▄▄▄▄██ ▒██▄█▓▒ ▒▒██▀▀█▄  ▒▓█  ▄░ ▓██▓ ░     ░ █ █ ▒ ▓▓█  ░██░▒██▀▀█▄  
▒███████▒ ▓█   ▓██▒▒██▒ ░  ░░██▓ ▒██▒░▒████▒ ▒██▒ ░    ▒██▒ ▒██▒▒▒█████▓ ░██▓ ▒██▒
░▒▒ ▓░▒░▒ ▒▒   ▓▒█░▒▓▒░ ░  ░░ ▒▓ ░▒▓░░░ ▒░ ░ ▒ ░░      ▒▒ ░ ░▓ ░░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░
░░▒ ▒ ░ ▒  ▒   ▒▒ ░░▒ ░       ░▒ ░ ▒░ ░ ░  ░   ░       ░░   ░▒ ░░░▒░ ░ ░   ░▒ ░ ▒░
░ ░ ░ ░ ░  ░   ▒   ░░         ░░   ░    ░    ░          ░    ░   ░░░ ░ ░   ░░   ░ 
  ░ ░          ░  ░            ░        ░  ░            ░    ░     ░        ░     
░                                                                                                                                                            
EOF
echo -e "\e[0m"
# =======================

echo -e "\e[32m==============================================\e[0m"
echo -e "\e[1mДобро пожаловать в установщик обхода дискорда и ютуба!\e[0m"
echo "Сделано с любовью от xurged!"
echo -e "\e[32m==============================================\e[0m"

install_dependencies() {
    kernel="$(uname -s)"

    if [ "$kernel" = "Linux" ]; then
        [ -f /etc/os-release ] && . /etc/os-release || { echo "Не удалось определить систему"; exit 1; }

        SUDO="${SUDO:-}"

        find_package_manager() {
            case "$1" in
                arch|artix|cachyos|endeavouros|manjaro|garuda) echo "$SUDO pacman -Syu --noconfirm && $SUDO pacman -S --noconfirm --needed git" ;;
                debian|ubuntu|mint) echo "$SUDO apt update -y && $SUDO apt install -y git" ;;
                fedora|almalinux|rocky|rhel|centos|oracle|redos) echo "if command -v dnf >/dev/null 2>&1; then $SUDO dnf check-update -y && $SUDO dnf install -y git; else $SUDO yum makecache -y && $SUDO yum install -y git; fi" ;;
                void)      echo "$SUDO xbps-install -S && $SUDO xbps-install -y git" ;;
                gentoo)    echo "$SUDO emerge --sync --quiet && $SUDO emerge --ask=n dev-vcs/git app-shells/bash" ;;
                opensuse)  echo "$SUDO zypper refresh && $SUDO zypper install git" ;;
                openwrt)   echo "$SUDO opkg update && $SUDO opkg install git git-http bash" ;;
                altlinux)  echo "$SUDO apt-get update -y && $SUDO apt-get install -y git bash" ;;
                alpine)    echo "$SUDO apk update && $SUDO apk add git bash" ;;
                *)         echo "" ;;
            esac
        }
    fi
}

while true; do
	echo -e "\n\e[34mВыберите действие:\e[0m"
	echo -e "\e[33m1) Установить Zapret\e[0m"
	echo -e "\e[33m2) Выход\e[0m"
	read -p "Введите номер > " choice

	case $choice in
		1)
			INSTALL_DIR="/opt/zapret.xur"
			ALT_DIR="/opt/zapret.xurged"
			GITHUB_REPO="https://github.com/xurged-dev/zapret-discord-main"
			if [ -d "$INSTALL_DIR" ]; then
				echo -e "\e[31mОбнаружена старая папка $INSTALL_DIR, удаляю...\e[0m"
				sudo rm -rf "$INSTALL_DIR"
			fi
			if [ -d "$ALT_DIR" ]; then
				echo -e "\e[31mОбнаружена старая папка $ALT_DIR, удаляю...\e[0m"
				sudo rm -rf "$ALT_DIR"
			fi

			echo -e "\e[36m\nСоздаю папку $INSTALL_DIR...\e[0m"
			sudo mkdir -p "$INSTALL_DIR"
			echo -e "\e[36mСкачиваю файлы запрета...\e[0m"
			sudo git clone "$GITHUB_REPO" "$INSTALL_DIR"
			echo -e "\e[32m\nУстановка завершена!.\e[0m"
			break
			;;
		2)
			echo -e "\e[31mВыход.\e[0m"
			exit 0
			;;
		*)
			echo -e "\e[31mНекорректный выбор. Пожалуйста, введите 1 или 2.\e[0m"
			;;
	esac
done
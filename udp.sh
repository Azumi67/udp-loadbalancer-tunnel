#!/bin/bash
# root check
if [[ $EUID -ne 0 ]]; then
  echo -e "\e[93mThis script must be run as root. Please use sudo -i.\e[0m"
  exit 1
fi

# bar
function display_progress() {
  local total=$1
  local current=$2
  local width=40
  local percentage=$((current * 100 / total))
  local completed=$((width * current / total))
  local remaining=$((width - completed))

  printf '\r['
  printf '%*s' "$completed" | tr ' ' '='
  printf '>'
  printf '%*s' "$remaining" | tr ' ' ' '
  printf '] %d%%' "$percentage"
}
function stop_loading() {
  echo -e "\r\xE2\x98\xBA \e[91mService activation stopped.\e[0m ~"
  return
}
# baraye checkmark
function display_checkmark() {
  echo -e "\xE2\x9C\x94 $1"
}

# error msg
function display_error() {
  echo -e "\xE2\x9D\x8C Error: $1"
}

# notify
function display_notification() {
  echo -e "\xE2\x9C\xA8 $1"
}
# Azumi is in your area
function display_loading() {
  local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local delay=0.1
  local duration=3  # Duration in seconds

  local end_time=$((SECONDS + duration))

  while ((SECONDS < end_time)); do
    for frame in "${frames[@]}"; do
      printf "\r[frame] Loading...  "
      sleep "$delay"
      printf "\r[frame]             "
      sleep "$delay"
    done
  done

  echo -e "\r\xE2\x98\xBA \e[91mService activated successfully!\e[0m ~"
}
#logo
function display_logo() {
echo -e "\033[1;96m$logo\033[0m"
}
#logo2
function display_logoo() {
    echo -e "\e[92m$logoo\e[0m"
}
#art2
logoo=$(cat << "EOF"

  _____       _     _      
 / ____|     (_)   | |     
| |  __ _   _ _  __| | ___ 
| | |_ | | | | |/ _` |/ _ \
| |__| | |_| | | (_| |  __/
 \_____|\__,_|_|\__,_|\___|
EOF
)
# art
logo=$(cat << "EOF"
⠀⠀               ⠄⠠⠤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⢀⠠⢀⣢⣈⣉⠁⡆⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀⡏⢠⣾⢷⢶⣄⣕⠢⢄⠀⠀⣀⣠⠤⠔⠒⠒⠒⠒⠒⠒⠢⠤⠄⣀⠤⢊⣤⣶⣿⡿⣿⢹⢀⡇⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀⢻⠈⣿⢫⡞⠛⡟⣷⣦⡝⠋⠉⣤⣤⣶⣶⣶⣿⣿⣿⡗⢲⣴⠀⠈⠑⣿⡟⡏⠀⢱⣮⡏⢨⠃⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀⠸⡅⣹⣿⠀⠀⢩⡽⠋⣠⣤⣿⣿⣏⣛⡻⠿⣿⢟⣹⣴⢿⣹⣿⡟⢦⣀⠙⢷⣤⣼⣾⢁⡾⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀             ⠀⢻⡀⢳⣟⣶⠯⢀⡾⢍⠻⣿⣿⣽⣿⣽⡻⣧⣟⢾⣹⡯⢷⡿⠁⠀⢻⣦⡈⢿⡟⠁⡼⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀             ⠀⢷⠠⢻⠏⢰⣯⡞⡌⣵⠣⠘⡉⢈⠓⡿⠳⣯⠋⠁⠀⠀⢳⡀⣰⣿⣿⣷⡈⢣⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀             ⠀⠀⠙⣎⠀⣿⣿⣷⣾⣷⣼⣵⣆⠂⡐⢀⣴⣌⠀⣀⣤⣾⣿⣿⣿⣿⣿⣿⣷⣀⠣⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀            ⠀⠀  ⠄⠑⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⣿⢽⣧⡤⢤⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀            ⠀⠀  ⢸⣈⢹⣟⣿⣿⣿⣿⣿⣻⢹⣿⣻⢿⣿⢿⣽⣳⣯⣿⢷⣿⡷⣟⣯⣻⣽⠧⠾⢤⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀             ⠀ ⢇⠤⢾⣟⡾⣽⣿⣽⣻⡗⢹⡿⢿⣻⠸⢿⢯⡟⡿⡽⣻⣯⣿⣎⢷⣣⡿⢾⢕⣎⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀             ⠀⡠⡞⡟⣻⣮⣍⡛⢿⣽⣻⡀⠁⣟⣣⠿⡠⣿⢏⡞⠧⠽⢵⣳⣿⣺⣿⢿⡋⠙⡀⠇⠱⠀⠀⠀
⠀⠀⠀             ⠀⢰⠠⠁⠀⢻⡿⣛⣽⣿⢟⡁\033[1;91m⣭⣥⣅⠀⠀⠀⠀⠀⠀⣶⣟⣧\033[1;96m⠿⢿⣿⣯⣿⡇⠀⡇⠀⢀⡇⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀⠀⢸⠀⠀⡇⢹⣾⣿⣿⣷⡿⢿\033[1;91m⢷⡏⡈⠀⠀⠀⠀⠀⠀⠈⡹⡷⡎\033[1;96m⢸⣿⣿⣿⡇⠀⡇⠀⠸⡇⠀⠀⠀⠀⠀⠀
⠀             ⠀⠀⠀⢸⡄⠂⠖⢸⣿⣿⣿⡏⢃⠘\033[1;91m⡊⠩⠁⠀⠀⠀⠀⠀⠀⠀⠁⠀⠁\033[1;96m⢹⣿⣿⣿⡇⢰⢁⡌⢀⠇⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀⠀⠀⢷⡘⠜⣤⣿⣿⣿⣷⡅⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣧⣕⣼⣠⡵⠋⠀⠀⠀⠀⠀⠀⠀
⠀⠀              ⠀⠀⠀⣸⣻⣿⣾⣿⣿⣿⣿⣾⡄⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⢀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀             ⠀⠀⡇⣿⣻⣿⣿⣿⣿⣿⣿⣿⣦⣤⣀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣳⣿⡸⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀⠀\033[1;96m⣸⢡⣿⢿⣿⣿⣿⣿⣿⣿⣿⢿⣿⡟⣽⠉⠀⠒⠂⠉⣯⢹⣿⡿⣿⣿⣿⣿⣿⣯⣿⡇⠇ ⡇ \e[32mAuthor: Azumi  \033[1;96m⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀             ⠀\033[1;96m⢰⡏⣼⡿⣿⣻⣿⣿⣿⣿⣿⢿⣻⡿⠁⠘⡆⠀⠀⠀⢠⠇⠘⣿⣿⣽⣿⣿⣿⣿⣯⣿⣷⣸⠀⠀ ⠀⠀⠀⠀
  \033[1;96m  ______   \033[1;94m _______  \033[1;92m __    \033[1;93m  _______     \033[1;91m   __      \033[1;96m _____  ___  
 \033[1;96m  /    " \  \033[1;94m|   __ "\ \033[1;92m|" \  \033[1;93m  /"      \    \033[1;91m  /""\     \033[1;96m(\"   \|"  \ 
 \033[1;96m // ____  \ \033[1;94m(. |__) :)\033[1;92m||  |  \033[1;93m|:        |   \033[1;91m /    \   \033[1;96m |.\\   \     |
 \033[1;96m/  /    ) :)\033[1;94m|:  ____/ \033[1;92m|:  |  \033[1;93m|_____/   )  \033[1;91m /' /\  \   \033[1;96m|: \.   \\   |
\033[1;96m(: (____/ // \033[1;94m(|  /     \033[1;92m|.  |  \033[1;93m //      /  \033[1;91m //  __'  \  \033[1;96m|.  \    \  |
 \033[1;96m\        / \033[1;94m/|__/ \    \033[1;92m/\  |\ \033[1;93m|:  __   \  \033[1;91m/   /  \\   \ \033[1;96m|    \    \ |
 \033[1;96m \"_____/ \033[1;94m(_______)  \033[1;92m(__\_|_)\033[1;93m|__|  \___)\033[1;91m(___/    \___) \033[1;96m\___|\____\)
EOF
)
function main_menu() {
    while true; do
        display_logo
        echo -e "\e[93m╔════════════════════════════════════════════════════════════════╗\e[0m"  
        echo -e "\e[93m║           ▌║█║▌│║▌│║▌║▌█║ \e[92mMain Menu\e[93m  ▌│║▌║▌│║║▌█║▌             ║\e[0m"   
        echo -e "\e[93m╠════════════════════════════════════════════════════════════════╣\e[0m" 
        display_service_status  
        display_service_statuss                                
        echo -e "\e[93m╔════════════════════════════════════════════════════════════════╗\e[0m"
        echo -e   "\e[91m      🌐 \e[92mJoin Opiran Telegram \e[34m@https://t.me/OPIranClub\e[0m \e[91m🌐\e[0m"
        echo -e "\e[93m╠════════════════════════════════════════════════════════════════╣\e[0m" 
        echo -e "1. \e[96mInstallation-[Frp-Udp2raw]\e[0m"                                 
        echo -e "2. \e[92mPrivate IP\e[0m"                                                 
        echo -e "3. \e[94mUDP Loadbalance [No Tunnel]\e[0m"                                            
        echo -e "4. \e[36mUDP Loadbalance + FRP Tunnel\e[0m"                               
        echo -e "5. \e[93mUDP Loadbalance + UDP Tunnel\e[0m"                               
        echo -e "6. \e[91mRestart Service\e[0m" 
		echo -e "7. \e[92mUninstall\e[0m" 
        echo "0. Exit"                                                             
        printf "\e[93m╰─────────────────────────────────────────────────────────────────╯\e[0m\n" 
        read -e -p $'\e[5mEnter your choice:  \e[0m' choice


        case $choice in
            1)
                installation_menu 
                ;;
			2)
                private_ip
                ;;				
            3)
                configure_load_balancing
                ;;
            4)
                udp_loadbalance_menu
                ;;
            5)
                UDP2raww_UDP_menu
                ;;
            6)
                restart_service
                ;;
            7)
                uninstall
                ;;
            0)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice."
                ;;
        esac

        echo "Press Enter to continue..."
        read
        clear
    done
}
function restart_service() {
    clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mRestart Menu\e[0m'
    echo $'\e[92m "-"\e[93m═════════════════════\e[0m'
	echo ""
	printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
    echo $'\e[93mSelect what to Restart:\e[0m'
    echo $'1. \e[92mNginx\e[0m'
    echo $'2. \e[93mFRP\e[0m'
    echo $'3. \e[91mUDP2raw\e[0m'
    echo $'4. \e[94mback to main menu\e[0m'
	printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
    read -e -p $'\e[38;5;205mEnter your choice Please: \e[0m' server_type
    case $server_type in
        1)
            nginx_menu
            ;;
        2)
            frpp_menu
            ;;
        3)
            udpp_menu
            ;;
        4)
            clear
            main_menu
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
}

function frpp_menu() {
    # Check 1
    systemctl daemon-reload
    systemctl restart azumifrpc.service > /dev/null 2>&1

    # Check 2
    systemctl restart azumifrps.service > /dev/null 2>&1
    display_checkmark $'\e[92mFRP Service restarted.\e[0m'

    
    echo "╭───────────────────────────────────────────╮"
    echo "│         Services Restarted                │"
    echo "│    services have been restarted!          │"
    echo "╰───────────────────────────────────────────╯"
}

function udpp_menu() {
    # Check 3
    systemctl restart azumi-udp2rawc.service > /dev/null 2>&1

    # Check 4
    systemctl restart azumi-udp2raws.service > /dev/null 2>&1
    display_checkmark $'\e[92mUDP2RAW Service restarted.\e[0m'

    
    echo "╭───────────────────────────────────────────╮"
    echo "│         Services Restarted                │"
    echo "│    services have been restarted!          │"
    echo "╰───────────────────────────────────────────╯"
}

function nginx_menu() {
    # Check 5
    systemctl restart nginx > /dev/null 2>&1
    display_checkmark $'\e[92mNginx Service restarted.\e[0m'

    
    echo "╭───────────────────────────────────────────╮"
    echo "│         Services Restarted                │"
    echo "│    services have been restarted!          │"
    echo "╰───────────────────────────────────────────╯"
}
function uninstall() {
    clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mUninstall Menu\e[0m'
    echo $'\e[92m "-"\e[93m═════════════════════\e[0m'
	echo ""
	printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
  echo $'\e[93mSelect what to uninstall:\e[0m'
  echo $'1. \e[92mPrivate IP\e[0m'
  echo $'2. \e[93mFRP\e[0m'
  echo $'3. \e[91mUDP2raw\e[0m'
  echo $'4. \e[33mNginx\e[0m'
  echo $'5. \e[94mback to main menu\e[0m'
	printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"

  read -e -p $'\e[38;5;205mEnter your choice Please: \e[0m' server_type
case $server_type in
        1)
            pri_uninstall_menu
            ;;
        2)
            frp_uninstall_menu
            ;;
		3)  
		    udp_uninstall_menu
            ;;		
		4)
            nginx_uni
            ;;			
        5)
            clear            
            main_menu
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
}
function nginx_uni() {
    clear
    echo "Uninstalling Nginx..."
    systemctl stop nginx > /dev/null 2>&1
    systemctl disable nginx > /dev/null 2>&1
    apt remove --purge nginx -y > /dev/null 2>&1
	
    display_notification $'\e[93mRemoving Nginx, Working in the background..\e[0m'

    echo -n "Progress: "

  local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local delay=0.1
  local duration=3  # Duration in seconds

  local end_time=$((SECONDS + duration))

  while ((SECONDS < end_time)); do
    for frame in "${frames[@]}"; do
      printf "\r[frame] Loading...  "
      sleep "$delay"
      printf "\r[frame]             "
      sleep "$delay"
    done
  done

    display_checkmark $'\e[92mNginx removed successfully!\e[0m'
}
function udp_uninstall_menu() {
    clear
    echo "Uninstalling UDP2raw..."
    systemctl stop --now "azumi-udp2raws.service" > /dev/null 2>&1
    systemctl disable --now "azumi-udp2raws.service" > /dev/null 2>&1
    systemctl stop --now "azumi-udp2rawc.service" > /dev/null 2>&1
    systemctl disable --now "azumi-udp2rawc.service" > /dev/null 2>&1
    rm -f /etc/systemd/system/azumi-udp2raws.service > /dev/null 2>&1
    rm -f /etc/systemd/system/azumi-udp2rawc.service > /dev/null 2>&1
	
    echo -n "Progress: "

      local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local delay=0.1
  local duration=3  # Duration in seconds

  local end_time=$((SECONDS + duration))

  while ((SECONDS < end_time)); do
    for frame in "${frames[@]}"; do
      printf "\r[frame] Loading...  "
      sleep "$delay"
      printf "\r[frame]             "
      sleep "$delay"
    done
  done

    display_checkmark $'\e[92mUDP2raw removed successfully!\e[0m'
}
function frp_uninstall_menu() {
    clear
    echo "Uninstalling FRP..."

    # Stop and disable azumifrps.service
    if systemctl is-active --quiet azumifrps; then
        systemctl stop azumifrps > /dev/null 2>&1
        systemctl disable azumifrps > /dev/null 2>&1  
    fi

    # Stop and disable azumifrpc.service
    if systemctl is-active --quiet azumifrpc; then
        systemctl stop azumifrpc > /dev/null 2>&1
        systemctl disable azumifrpc > /dev/null 2>&1  
    fi

    # Remove azumifrps.service file
    if rm /etc/systemd/system/azumifrps.service 2>/dev/null; then
        display_checkmark $'\e[92mService removed.\e[0m'
    else
        echo -e "\e[91mFailed to remove azumifrps.service.\e[0m"
    fi

    # Remove azumifrpc.service file
    if rm /etc/systemd/system/azumifrpc.service 2>/dev/null; then
        display_checkmark $'\e[92mService removed.\e[0m'
    else
        echo -e "\e[91mFailed to remove azumifrpc.service.\e[0m"
    fi

    # symbolic
    if rm /etc/systemd/system/multi-user.target.wants/azumifrps.service 2>/dev/null; then
        display_checkmark $'\e[92mSymbolic link removed.\e[0m' 
    else
        echo -e "\e[91mFailed to remove symbolic link for azumifrps.service.\e[0m"
    fi

    if rm /etc/systemd/system/multi-user.target.wants/azumifrpc.service 2>/dev/null; then
        display_checkmark $'\e[92mSymbolic link removed.\e[0m'
    else
        echo -e "\e[91mFailed to remove symbolic link for azumifrpc.service.\e[0m"
    fi

    echo "Removing FRP, Working in the background..."
    echo -n "Progress: "

      local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local delay=0.1
  local duration=3  # Duration in seconds

  local end_time=$((SECONDS + duration))

  while ((SECONDS < end_time)); do
    for frame in "${frames[@]}"; do
      printf "\r[frame] Loading...  "
      sleep "$delay"
      printf "\r[frame]             "
      sleep "$delay"
    done
  done

    display_checkmark $'\e[92mFRP Uninstalled!\e[0m'
}
function pri_uninstall_menu() {
    echo -e "\e[93mRemoving private IP addresses...\e[0m"
    if [ -f "/etc/private.sh" ]; then
        rm /etc/private.sh
    fi
    display_notification $'\e[93mRemoving cron job..\e[0m'
    crontab -l | grep -v "@reboot /bin/bash /etc/private.sh" | crontab -
    sleep 1
 
    systemctl disable ping_v6.service > /dev/null 2>&1
    systemctl stop ping_v6.service > /dev/null 2>&1
    rm /etc/systemd/system/ping_v6.service > /dev/null 2>&1
    sleep 1

    systemctl daemon-reload

    ip link set dev azumi down > /dev/null
    ip tunnel del azumi > /dev/null

    echo -n "Progress: "

      local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local delay=0.1
  local duration=3  # Duration in seconds

  local end_time=$((SECONDS + duration))

  while ((SECONDS < end_time)); do
    for frame in "${frames[@]}"; do
      printf "\r[frame] Loading...  "
      sleep "$delay"
      printf "\r[frame]             "
      sleep "$delay"
    done
  done

    display_checkmark $'\e[92mPrivate IP removed successfully!\e[0m'
}
function installation_menu() {
   clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mInstallation Menu\e[0m'
    echo $'\e[92m "-"\e[93m═════════════════════\e[0m'
	echo ""
	printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
    echo "Select what to install:"
    echo $'1. \e[92mFRP\e[0m'
    echo $'2. \e[93mUDP2RAW\e[0m'
    echo $'3. \e[94mback to main menu\e[0m'
	printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
    read -e -p $'\e[38;5;205mEnter your choice Please: \e[0m' server_type
case $server_type in
        1)
            frp_menu
            ;;
        2)
            udp_menu
            ;;
        3)
            clear            
            main_menu
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
}

frp_menu() {
    # Function to stop the loading animation and exit
    function stop_loading() {
        echo -e "\xE2\x9D\x8C Installation process interrupted."
        exit 1
    }

    # (Ctrl+C)
    trap stop_loading INT
    # ip forward
    sysctl -w net.ipv4.ip_forward=1 &>/dev/null
    sysctl -w net.ipv6.conf.all.forwarding=1 &>/dev/null

    # dns
    echo "nameserver 8.8.8.8" > /etc/resolv.conf

    # Apply sysctl settings to enable IPv4 and IPv6
    sysctl -w net.ipv4.ip_forward=1 &>/dev/null
    sysctl -w net.ipv6.conf.all.forwarding=1 &>/dev/null

    # DNS baraye install
    echo "nameserver 8.8.8.8" > /etc/resolv.conf

    # CPU architecture
    arch=$(uname -m)

    # cpu architecture
    case $arch in
        x86_64 | amd64)
            frp_download_url="https://github.com/fatedier/frp/releases/download/v0.52.3/frp_0.52.3_linux_amd64.tar.gz"
            ;;
        aarch64 | arm64)
            frp_download_url="https://github.com/fatedier/frp/releases/download/v0.52.3/frp_0.52.3_linux_arm64.tar.gz"
            ;;
        *)
            display_error "Unsupported CPU architecture: $arch"
            return
            ;;
    esac

    # Download FRP notificatiooooons
    display_notification $'\e[91mDownloading FRP in a sec...\e[0m'
    display_notification $'\e[91mPlease wait, updating...\e[0m'

    # timer
    SECONDS=0

    # Update in the background
    apt update &>/dev/null &
    apt_update_pid=$!

    # Timer
    while [[ -n $(ps -p $apt_update_pid -o pid=) ]]; do
        clear
        display_notification $'\e[93mPlease wait, updating...\e[0m'
        display_notification $'\e[93mAzumi is working in the background, timer: \e[0m'"$SECONDS seconds"
        sleep 1
    done

    # progress bar
    for ((i=0; i<=10; i++)); do
        sleep 0.5
        display_progress 10 $i
    done

    display_checkmark $'\e[92mUpdate completed successfully!\e[0m'

    # Download the appropriate FRP version
    wget "$frp_download_url" -O frp.tar.gz &>/dev/null
    tar -xf frp.tar.gz &>/dev/null

    display_checkmark $'\e[92mFRP installed successfully!\e[0m'

    # sysctl setting
    sysctl -p &>/dev/null

    # notify
    display_notification $'\e[92mIP forward enabled!\e[0m'
    display_loading

    # interrupt
    trap - INT
}
function udp_menu() {

    # clean up
    stop_loading() {
        kill $loading_bar_pid &>/dev/null
        echo ""
    }

    # (Ctrl+C)
    trap stop_loading INT

 # add DNS address
    echo "nameserver 8.8.8.8" >> /etc/resolv.conf > /dev/null
    display_checkmark $'\e[92mTemporary DNS added.\e[0m'

    # modify sysctl.conf
    echo -e "\033[93mModifying sysctl.conf...\033[0m"
    sed -i '/^#net\.ipv4\.ip_forward=/s/^#//' /etc/sysctl.conf > /dev/null
    sed -i '/^#net\.ipv6\.conf\.all\.forwarding=/s/^#//' /etc/sysctl.conf > /dev/null
    display_checkmark $'\e[92mIP forward enabled.\e[0m'

    # Azumi is working in the background
 (
    while true; do
        echo -ne "\033[92mRunning update:  [          ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [█         ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [██        ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [███       ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [████      ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [█████     ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [██████    ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
        echo -ne "\033[92mRunning update:  [███████   ]  $(printf "%02d:%02d" $((SECONDS/60)) $((SECONDS%60)))  \r\033[0m"
        sleep 0.3
    done
) &

    loading_bar_pid=$!
    # run update 
    apt update > /dev/null 2>&1
	apt install wget > /dev/null 2>&1

    # clean up
    stop_loading

   display_checkmark $'\e[92mUpdate completed.\e[0m'
   sleep 1
   echo -e "\033[93mInstalling UDP2raw...\033[0m"
   sleep 1
   echo -e "\033[93mDownloading UDP2raw package...\033[0m"

    # Loading for FRP
    (
while true; do
    echo -ne "\033[94mLoading: [\033[1m=\033[0m          ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m==\033[0m         ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m===\033[0m        ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m====\033[0m       ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m=====\033[0m      ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m======\033[0m     ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m=======\033[0m    ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m========\033[0m   ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m=========\033[0m  ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m==========\033[0m ]\r"
    sleep 0.5
    echo -ne "\033[94mLoading: [\033[1m===========\033[0m]\r"
    sleep 0.5
done
) &
 
    loading_bar_pid=$!
system_architecture=$(uname -m)

if [ "$system_architecture" != "x86_64" ] && [ "$system_architecture" != "amd64" ] && [ "$system_architecture" != "arm" ]; then
    echo "Unsupported architecture: $system_architecture" > /dev/null
    exit 1
fi

sleep 1
echo ""
echo -e "${YELLOW}Downloading and installing udp2raw for architecture: $system_architecture${NC}" 

if [ "$system_architecture" == "x86_64" ] || [ "$system_architecture" == "amd64" ]; then
    wget https://github.com/Azumi67/udp2raw-core/raw/main/udp2raw_amd64 &>/dev/null
elif [ "$system_architecture" == "arm" ]; then
    wget https://github.com/Azumi67/udp2raw-core/raw/main/udp2raw_arm &>/dev/null
fi
sleep 1

chmod +x udp2raw_amd64 &>/dev/null
chmod +x udp2raw_arm &>/dev/null
    stop_loading

    display_checkmark $'\e[92mUDP2raw installation completed.\e[0m'


    # setup time
    duration=$SECONDS
    echo -e "\033[93mInstallation completed in \033[92m$(($duration / 60)) minutes and $(($duration % 60)) seconds.\033[0m"

    # interrupt
    trap - INT
}
function private_ip() {
   clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mPrivate IP Menu\e[0m'
    echo $'\e[92m "-"\e[93m═════════════════════\e[0m'
	display_logoo
echo -e "\e[93m.-------------------------------------------------------------------------------------------------------.\e[0m"
echo -e "\e[93m| \e[92mYou can use private ip for tunnel after you have created your loadbalance or you can use native ipv6  \e[93m|\e[0m"
echo -e "\e[93m|\e[0m  First create private ip on kharej and then iran                                                      \e[93m|\e[0m"
echo -e "\e[93m'-------------------------------------------------------------------------------------------------------'\e[0m"
  printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
  echo $'\e[93mChoose what to do:\e[0m'
  echo $'1. \e[92mKharej\e[0m'
  echo $'2. \e[91mIRAN\e[0m'
  echo $'3. \e[94mback to main menu\e[0m'
  printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
  read -e -p $'Enter your choice Please: ' server_type
  
case $server_type in
    1)
        kharej_private_menu
        ;;
    2)
        iran_private_menu
        ;;
    3)
        clear
        main_menu
        ;;
    *)
        echo "Invalid choice."
        ;;
esac
}
function kharej_private_menu() {
      clear
	  echo $'\e[92m ^ ^\e[0m'
      echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
      echo $'\e[92m(   ) \e[93mConfiguring kharej server\e[0m'
      echo $'\e[92m "-"\e[93m══════════════════════════\e[0m'
	  display_logoo
      printf "\e[93m╭────────────────────────────────────────────────────────────────────────────────────╮\e[0m\n"
        echo $'\e[92m   Please make sure to remove any private IPs that you have created before proceeding\e[0m'
      printf "\e[93m╰────────────────────────────────────────────────────────────────────────────────────╯\e[0m\n"
    echo -e "\e[0mAdding private IP addresses for Kharej server...\e[0m"
    if [ -f "/etc/private.sh" ]; then
        rm /etc/private.sh
    fi

# Q&A
printf "\e[93m╭─────────────────────────────────────────────────────────╮\e[0m\n"
read -e -p $'\e[93mEnter \e[92mKharej\e[93m IPV4 address: \e[0m' local_ip
read -e -p $'\e[93mEnter \e[92mIRAN\e[93m IPV4 address: \e[0m' remote_ip


# ip commands
ip tunnel add azumi mode sit remote $remote_ip local $local_ip ttl 255 > /dev/null

ip link set dev azumi up > /dev/null
 
# iran initial IP address
initial_ip="fd1d:fc98:b73e:b481::1/64"
ip addr add $initial_ip dev azumi > /dev/null

# additional private IPs-number
read -e -p $'How many additional \e[92mprivate IPs\e[93m do you need? \e[0m' num_ips
printf "\e[93m╰─────────────────────────────────────────────────────────╯\e[0m\n"

# additional private IPs
for ((i=1; i<=num_ips; i++))
do
  ip_suffix=`printf "%x\n" $i`
  ip_addr="fd1d:fc98:b73e:b48${ip_suffix}::1/64"  > /dev/null
  
  # Check kharej
  ip addr show dev azumi | grep -q "$ip_addr"
  if [ $? -eq 0 ]; then
    echo "IP address $ip_addr already exists. Skipping..."
  else
    ip addr add $ip_addr dev azumi
  fi
done

    # private.sh
	display_notification $'\e[93mAdding commands to private.sh...\e[0m'
    echo "ip tunnel add azumi mode sit remote $remote_ip local $local_ip ttl 255" >> /etc/private.sh
    echo "ip link set dev azumi up" >> /etc/private.sh
    echo "ip addr add fd1d:fc98:b73e:b481::1/64 dev azumi" >> /etc/private.sh
        ip_addr="fd1d:fc98:b73e:b48${ip_suffix}::1/64"
        echo "ip addr add $ip_addr dev azumi" >> /etc/private.sh

    display_checkmark $'\e[92mPrivate ip added successfully!\e[0m'

display_notification $'\e[93mAdding cron job for server!\e[0m'
    (crontab -l 2>/dev/null; echo "@reboot /bin/bash /etc/private.sh") | crontab -
	
	ping -c 2 fd1d:fc98:b73e:b481::2 | sed "s/.*/\x1b[94m&\x1b[0m/" 
	sleep 1
	display_notification $'\e[93mConfiguring keepalive service..\e[0m'

    # script
script_content='#!/bin/bash

# IPv6 address
ip_address="fd1d:fc98:b73e:b481::2"

# maximum number
max_pings=4

# Interval
interval=60

# Loop run
while true
do
    # Loop for pinging specified number of times
    for ((i = 1; i <= max_pings; i++))
    do
        ping_result=$(ping -c 1 $ip_address | grep "time=" | awk -F "time=" "{print $2}" | awk -F " " "{print $1}" | cut -d "." -f1)
        if [ -n "$ping_result" ]; then
            echo "Ping successful! Response time: $ping_result ms"
        else
            echo "Ping failed!"
        fi
    done

    echo "Waiting for $interval seconds..."
    sleep $interval
done'

echo "$script_content" | sudo tee /etc/ping_v6.sh > /dev/null

    chmod +x /etc/ping_v6.sh
# service file
    cat <<EOF > /etc/systemd/system/ping_v6.service
[Unit]
Description=keepalive
After=network.target

[Service]
ExecStart=/bin/bash /etc/ping_v6.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    systemctl enable ping_v6.service
    systemctl start ping_v6.service
    display_checkmark $'\e[92mPing Service has been added successfully!\e[0m'	
	
# display 
echo ""
echo -e "Created \e[93mPrivate IP Addresses \e[92m(Kharej):\e[0m"
for ((i=1; i<=num_ips; i++))
do
    ip_suffix=`printf "%x\n" $i`
    ip_addr="fd1d:fc98:b73e:b48${ip_suffix}::1"
    echo "+---------------------------+"
    echo -e "| \e[92m$ip_addr    \e[0m|"
done
echo "+---------------------------+"
}
# private IP for Iran
function iran_private_menu() {
      clear
	  echo $'\e[92m ^ ^\e[0m'
      echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
      echo $'\e[92m(   ) \e[93mConfiguring Iran server\e[0m'
      echo $'\e[92m "-"\e[93m══════════════════════════\e[0m'
	  display_logoo
      printf "\e[93m╭────────────────────────────────────────────────────────────────────────────────────╮\e[0m\n"
        echo $'\e[92m  Please make sure to remove any private IPs that you have created before proceeding\e[0m'
      printf "\e[93m╰────────────────────────────────────────────────────────────────────────────────────╯\e[0m\n"
    echo -e "\e[0mAdding private IP addresses for Kharej server...\e[0m"
    if [ -f "/etc/private.sh" ]; then
        rm /etc/private.sh
    fi

# Q&A
printf "\e[93m╭─────────────────────────────────────────────────────────╮\e[0m\n"
read -e -p $'\e[93mEnter \e[92mKharej\e[93m IPV4 address: \e[0m' remote_ip
read -e -p $'\e[93mEnter \e[92mIRAN\e[93m IPV4 address: \e[0m' local_ip


# ip commands
ip tunnel add azumi mode sit remote $remote_ip local $local_ip ttl 255 > /dev/null

ip link set dev azumi up > /dev/null
 
# iran initial IP address
initial_ip="fd1d:fc98:b73e:b481::2/64"
ip addr add $initial_ip dev azumi > /dev/null

# additional private IPs-number
read -e -p $'How many additional \e[92mprivate IPs\e[93m do you need? \e[0m' num_ips
printf "\e[93m╰─────────────────────────────────────────────────────────╯\e[0m\n"
# additional private IPs
for ((i=1; i<=num_ips; i++))
do
  ip_suffix=`printf "%x\n" $i`
  ip_addr="fd1d:fc98:b73e:b48${ip_suffix}::2/64" > /dev/null
  
  # Check iran
  ip addr show dev azumi | grep -q "$ip_addr"
  if [ $? -eq 0 ]; then
    echo "IP address $ip_addr already exists. Skipping..."
  else
    ip addr add $ip_addr dev azumi
  fi
done
# private.sh
    echo -e "\e[93mAdding commands to private.sh...\e[0m"
    echo "ip tunnel add azumi mode sit remote $remote_ip local $local_ip ttl 255" >> /etc/private.sh
    echo "ip link set dev azumi up" >> /etc/private.sh
    echo "ip addr add fd1d:fc98:b73e:b481::2/64 dev azumi" >> /etc/private.sh
        ip_addr="fd1d:fc98:b73e:b48${ip_suffix}::2/64"
        echo "ip addr add $ip_addr dev azumi" >> /etc/private.sh
    
    chmod +x /etc/private.sh

    display_checkmark $'\e[92mPrivate ip added successfully!\e[0m'


    display_notification $'\e[93mAdding cron job for server!\e[0m'
    (crontab -l 2>/dev/null; echo "@reboot /bin/bash /etc/private.sh") | crontab -

	ping -c 2 fd1d:fc98:b73e:b481::1 | sed "s/.*/\x1b[94m&\x1b[0m/" 
	sleep 1
	display_notification $'\e[93mConfiguring keepalive service..\e[0m'

# script
script_content='#!/bin/bash

# iPv6 address
ip_address="fd1d:fc98:b73e:b481::1"


max_pings=3

# interval
interval=50

# loop run
while true
do
    # Loop for pinging specified number of times
    for ((i = 1; i <= max_pings; i++))
    do
        ping_result=$(ping -c 1 $ip_address | grep "time=" | awk -F "time=" "{print $2}" | awk -F " " "{print $1}" | cut -d "." -f1)
        if [ -n "$ping_result" ]; then
            echo "Ping successful! Response time: $ping_result ms"
        else
            echo "Ping failed!"
        fi
    done

    echo "Waiting for $interval seconds..."
    sleep $interval
done'

echo "$script_content" | sudo tee /etc/ping_v6.sh > /dev/null

    chmod +x /etc/ping_v6.sh
# service file
    cat <<EOF > /etc/systemd/system/ping_v6.service
[Unit]
Description=keepalive
After=network.target

[Service]
ExecStart=/bin/bash /etc/ping_v6.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    systemctl enable ping_v6.service
    systemctl start ping_v6.service
    display_checkmark $'\e[92mPing Service has been added successfully!\e[0m'

# display
echo ""
echo -e "Created \e[93mPrivate IP Addresses \e[92m(Iran):\e[0m"
for ((i=1; i<=num_ips; i++))
do
    ip_suffix=`printf "%x\n" $i`
    ip_addr="fd1d:fc98:b73e:b48${ip_suffix}::2"
    echo "+---------------------------+"
    echo -e "| \e[92m$ip_addr    \e[0m|"
done
echo "+---------------------------+"
}
function UDP2raww_UDP_menu() {
  clear
  echo $'\e[92m ^ ^\e[0m'
  echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
  echo $'\e[92m(   ) \e[93mLoadbalance + udp2raw Tunnel\e[0m'
  echo $'\e[92m "-"\e[93m═══════════════════════════════\e[0m'
  display_logoo
  echo -e "\e[93m.-------------------------------------------------------------------------------------------.\e[0m"
  echo -e "\e[93m| \e[92mFirst start udp loadbalance on kharej and save your loadbalance port on a notepad         \e[93m|\e[0m"
  echo -e "\e[93m|\e[0m Establish the tunnel first on Kharej and then on iran                                     \e[93m|\e[0m"
  echo -e "\e[93m'-------------------------------------------------------------------------------------------'\e[0m"
  printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
  echo $'\e[93mSelect what to install:\e[0m'
  echo $'1. \e[92mUDP Loadbalance [Run on kharej]\e[0m'
  echo $'2. \e[36mKharej\e[0m'
  echo $'3. \e[93mIRAN\e[0m'
  echo $'4. \e[94mback to main menu\e[0m'
  printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
  read -e -p $'\e[38;5;205mEnter your choice Please: \e[0m' server_type
  
case $server_type in
        1)
		    load_balance_tunnel
			;;
		2)	
            udp2raww_kharej_menu
            ;;
        3)
            udp2raww_iran_menu
            ;;
        4)
            clear            
            main_menu
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
}
function udp2raww_kharej_menu() {
    clear
  echo $'\e[92m ^ ^\e[0m'
  echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
  echo $'\e[92m(   ) \e[93mudp2raw Tunnel- Kharej\e[0m'
  echo $'\e[92m "-"\e[93m═══════════════════════════════\e[0m'
  display_logoo
  echo -e "\e[93m.--------------------------------------------------------------------------.\e[0m"
  echo -e "\e[93m| \e[92mUse your loadbalance port instead of your kharej wireguard port          \e[93m|\e[0m"
  echo -e "\e[93m|\e[0m Your wireguard endpoint : IPV4-IRAN:Loadbalance port                     \e[93m|\e[0m"
  echo -e "\e[93m'---------------------------------------------------------------------------\e[0m"
    printf "\e[93m╭─────────────────────────────────────────────────────╮\e[0m\n"
    read -e -p $'\e[93mEnter \e[92mTunnel\e[93m port\e[92m[example: 443]\e[0m :  ' local_port
    read -e -p $'\e[93mEnter \e[92mLoadbalance\e[93m port\e[92m[example: 50820]\e[0m :  ' remote_port
	read -e -p $'\e[93mEnter \e[92mTunnel\e[93m password\e[92m[Same value for Kharej & Iran]\e[0m :  ' password
    echo -e "\e[93m protocol \e[92m(Mode) \e[93m(Iran & Kharej value should be the same)\e[0m"
    echo -e "1.\e[93mudp\e[0m"
    echo -e "2.\e[93mfaketcp\e[0m"
    echo -e "3.\e[93micmp\e[0m"
	printf "\e[93m╰──────────────────────────────────────────────────────╯\e[0m\n"
    echo -e "\e[93mEnter your choice [1-3] : \e[0m"
    read protocol_choice

    case $protocol_choice in
        1)
            raw_mode="udp"
            ;;
        2)
            raw_mode="faketcp"
            ;;
        3)
            raw_mode="icmp"
            ;;
        *)
            echo -e "\e[91mInvalid choice, choose correctly ...\e[0m"
            ;;
    esac

    echo -e "\e[36mSelected protocol: \e[32m$raw_mode\e[0m"

# architecture
if [[ "$(uname -m)" == "x86_64" ]]; then
  cpu_arch="amd64"
elif [[ "$(uname -m)" == "aarch64" ]]; then
  cpu_arch="arm"
else
  echo -e "\e[93mUnsupported CPU architecture.\e[0m"
  exit 1
fi
    # cpu architecture
config_file="/etc/systemd/system/azumi-udp2raws.service"
udp2raw_exec="/root/udp2raw_$cpu_arch"



# service file
cat << EOF > "$config_file"
[Unit]
Description=udp2raw-s Service
After=network.target

[Service]
ExecStart=$udp2raw_exec -s -l [::]:${local_port} -r 127.0.0.1:${remote_port} -k "${password}" --raw-mode ${raw_mode} -a
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    sleep 1
    systemctl daemon-reload
    systemctl restart "azumi-udp2raws.service" > /dev/null 2>&1
    systemctl enable --now "azumi-udp2raws.service" > /dev/null 2>&1
    systemctl start --now "azumi-udp2raws.service" > /dev/null 2>&1
    sleep 1

    display_checkmark $'\e[92mKharej configuration has been adjusted and service started. Yours truly, Azumi\e[0m'
}

function udp2raww_iran_menu() {
    clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mudp2raw Tunnel- Iran\e[0m'
    echo $'\e[92m "-"\e[93m═══════════════════════════════\e[0m'
	display_logoo
    echo -e "\e[93m.--------------------------------------------------------------.\e[0m"
    echo -e "\e[93m| \e[92mUse the same port you've used on the kharej server           \e[93m|\e[0m"
	echo -e "\e[93m| \e[93mUse kharej native ipv6 or kharej private ip address          \e[93m|\e[0m"
    echo -e "\e[93m| \e[0mYour wireguard endpoint : IPV4-IRAN:Loadbalance port         \e[93m|\e[0m"
    echo -e "\e[93m'--------------------------------------------------------------'\e[0m"
	printf "\e[93m╭─────────────────────────────────────────────────────╮\e[0m\n"
    read -e -p $'\e[93mEnter \e[92mTunnel\e[93m port \e[92m[example: 443]\e[0m :  ' remote_port
	
    read -e -p $'\e[93mEnter \e[92mLoadbalancer\e[93m port \e[92m[example: 50820]\e[0m:  ' local_port

    read -e -p $'\e[93mEnter \e[92mTunnel\e[93m password \e[92m[Same value for Kharej & Iran]\e[0m:  ' password
	
    read -e -p $'\e[93mEnter \e[92mKharej\e[93m ipv6 address:\e[0m ' remote_address

    echo -e "\e[93m protocol \e[92m(Mode) \e[93m(Iran & Kharej value should be the same)\e[0m"

    echo -e "1.\e[93mudp\e[0m"
    echo -e "2.\e[93mfaketcp\e[0m"
    echo -e "3.\e[93micmp\e[0m"
 
	printf "\e[93m╰──────────────────────────────────────────────────────╯\e[0m\n"
    echo -e "\e[93mEnter your choice [1-3] : \e[0m"
    read protocol_choice

    case $protocol_choice in
        1)
            raw_mode="udp"
            ;;
        2)
            raw_mode="faketcp"
            ;;
        3)
            raw_mode="icmp"
            ;;
        *)
            echo -e "\e[91mInvalid choice, choose correctly ...\e[0m"
            ;;
    esac

    echo -e "\e[36mSelected protocol: \e[32m$raw_mode\e[0m"

    # architecture
if [[ "$(uname -m)" == "x86_64" ]]; then
  cpu_arch="amd64"
elif [[ "$(uname -m)" == "aarch64" ]]; then
  cpu_arch="arm"
else
  echo -e "\e[93mUnsupported CPU architecture.\e[0m"
  exit 1
fi
    # cpu architecture
config_file="/etc/systemd/system/azumi-udp2rawc.service"
udp2raw_exec="/root/udp2raw_$cpu_arch"

echo -e "\e[36mSelected protocol: \e[32m$raw_mode\e[0m"

# service file
cat << EOF > "$config_file"
[Unit]
Description=udp2raw-c Service
After=network.target

[Service]
ExecStart=$udp2raw_exec -c -l [::]:${local_port} -r [${remote_address}]:${remote_port} -k ${password} --raw-mode ${raw_mode} -a
Restart=always

[Install]
WantedBy=multi-user.target
EOF


sleep 1
systemctl daemon-reload
systemctl restart "azumi-udp2rawc.service" > /dev/null 2>&1
systemctl enable --now "azumi-udp2rawc.service" > /dev/null 2>&1
systemctl start --now "azumi-udp2rawc.service" > /dev/null 2>&1

display_checkmark $'\e[92mIran configuration has been adjusted and service started. Yours truly, Azumi\e[0m'
}

function display_service_status() {
  sudo systemctl is-active azumifrpc.service &>/dev/null
  local frpc_status=$?
  if [[ $frpc_status -eq 0 ]]; then
    frpc_status_msg="\e[92m\xE2\x9C\x94 FRP Kharej service is running\e[0m"
  else
    frpc_status_msg="\e[91m\xE2\x9C\x98 FRP Kharej service is not running\e[0m"
  fi

  sudo systemctl is-active azumifrps.service &>/dev/null
  local frps_status=$?
  if [[ $frps_status -eq 0 ]]; then
    frps_status_msg="\e[92m\xE2\x9C\x94 FRP Iran service is running\e[0m"
  else
    frps_status_msg="\e[91m\xE2\x9C\x98 FRP Iran service is not running\e[0m"
  fi

  # FRP service status
  printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
  printf "\e[93m  %-35b \e[0m\n" "$frpc_status_msg"     
  printf "\e[93m  %-35b \e[0m\n" "$frps_status_msg"
  printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
}


function display_service_statuss() {
  sudo systemctl is-active azumi-udp2raws.service &>/dev/null
  local udp2raws_status=$?
  if [[ $udp2raws_status -eq 0 ]]; then
    udp2raws_status_msg="\e[92m\xE2\x9C\x94 udp2raw Kharej is running\e[0m"
  else
    udp2raws_status_msg="\e[91m\xE2\x9C\x98 udp2raw Kharej is not running\e[0m"
  fi

  sudo systemctl is-active azumi-udp2rawc.service &>/dev/null
  local udp2rawc_status=$?
  if [[ $udp2rawc_status -eq 0 ]]; then
    udp2rawc_status_msg="\e[92m\xE2\x9C\x94 udp2raw Iran service is running\e[0m"
  else
    udp2rawc_status_msg="\e[91m\xE2\x9C\x98 udp2raw Iran is not running\e[0m"
  fi

  # UDP2raw service status
  printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"
  printf "\e[93m  %-35b \e[0m\n" "$udp2raws_status_msg"  
  printf "\e[93m  %-35b \e[0m\n" "$udp2rawc_status_msg"
  printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
}
function udp_loadbalance_menu() {
   clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mLoadbalance + FRP Tunnel\e[0m'
    echo $'\e[92m "-"\e[93m═══════════════════════════════\e[0m'
	display_logoo
    echo -e "\e[93m.--------------------------------------------------------------------------------------------.\e[0m"
    echo -e "\e[93m| \e[92mFirst Run Loadbalance on kharej server and save loadbalance port on a notepad              \e[93m|\e[0m"
    echo -e "\e[93m| \e[93mFor tunnel, 1st Establish the tunnel on iran server and then on kharej server              \e[93m|\e[0m"
    echo -e "\e[93m'--------------------------------------------------------------------------------------------'\e[0m"

  printf "\e[93m╭───────────────────────────────────────╮\e[0m\n"	
  echo $'\e[93mChoose what to do:\e[0m'
  echo $'1. \e[36mUDP Loadbalance [ Run on kharej]\e[0m'
  echo $'2. \e[92mFRP Kharej\e[0m'
  echo $'3. \e[93mFRP IRAN\e[0m'
  echo $'4. \e[94mback to main menu\e[0m'
  printf "\e[93m╰───────────────────────────────────────╯\e[0m\n"
  read -e -p $'\e[38;5;205mEnter your choice Please: \e[0m' server_type
case $server_type in
    1)
	    load_balance_tunnel
		;;
    2)
        kharej__frp_tunnel
        ;;
    3)
        iran_frp_tunnel
        ;;
    4)
        clear
        main_menu
        ;;
    *)
        echo "Invalid choice."
        ;;
esac
}
message="This loadbalancer port should be used for FRP & UDP2RAW tunnel, save it on a notepad >> [$stream_port]"
box_width=100

display_boxx() {
    local message="$1"
    local padding=$(( (box_width - ${#message} - 2) / 2 ))
    local border_line="╔$(printf '═%.0s' $(seq 1 $((box_width-2))))╗"
    local padding_line="$(printf ' %.0s' $(seq 1 $padding))$message$(printf ' %.0s' $(seq 1 $padding))"
    local bottom_line="╚$(printf '═%.0s' $(seq 1 $((box_width-2))))╝"

    printf "%s\n" "$border_line"
    printf "%s\n" "$padding_line"
    printf "%s\n" "$bottom_line"
}

function load_balance_tunnel() {
    clear
# (Ctrl+C)
    trap stop_loading INT
 # ip forward
  sysctl -w net.ipv4.ip_forward=1 &>/dev/null
  sysctl -w net.ipv6.conf.all.forwarding=1 &>/dev/null

  # dns
  echo "nameserver 8.8.8.8" > /etc/resolv.conf

# IPv4 and IPv6
  sysctl -w net.ipv4.ip_forward=1 &>/dev/null
  sysctl -w net.ipv6.conf.all.forwarding=1 &>/dev/null

  # DNS baraye install
  echo "nameserver 8.8.8.8" > /etc/resolv.conf

  # download
  display_notification $'\e[91mPlease wait, updating...\e[0m'

  # start a timer.. heeey
  SECONDS=0

# background
apt update &>/dev/null &
apt_update_pid=$!

# timer
SECONDS=0

while [[ -n $(ps -p $apt_update_pid -o pid=) ]]; do
    clear
    display_notification $'\e[93mPlease wait, updating...\e[0m'
    display_notification $'\e[93mAzumi is working in the background, timer: \e[0m'"$SECONDS seconds"
    sleep 1
done

# nginx
apt install -y nginx &>/dev/null & nginx_install_pid=$!

  # progress bar 
  for ((i=0; i<=10; i++)); do
    sleep 0.5
    display_progress 10 $i
  done

  display_checkmark $'\e[92mNginx installed successfully!\e[0m'

# sysctl setting
  sysctl -p &>/dev/null

  # notify
  display_notification $'\e[92mIP forward enabled!\e[0m'
  display_loading
# interrupt
    trap - INT

    sleep 1
    local stream_port=""
    local server_port=""
    local ipv6_addresses=()
    local weights=()
# loadbalance port
YELLOW='\e[93m'
GREEN='\e[92m'
NC='\e[0m'
    display_logoo
    echo -e "\e[93m.--------------------------------------------------------------------------------------------------.\e[0m"
    echo -e "\e[93m| \e[92mEnter your loadbalance port, this will be used for tunnel purpose                                \e[93m|\e[0m"
    echo -e "\e[93m| \e[93mEnter your current wireguard port and select how many ipv6 do you need for the loadbalancer      \e[93m|\e[0m"
	echo -e "|  Kharej IPV6 should be native for this purpose.                                                  |"
    echo -e "\e[93m'--------------------------------------------------------------------------------------------------'\e[0m"
	echo ""
printf "\e[93m╭───────────────────────────────────────────────────────────╮\e[0m\n"
read -e -p "$(echo -e "${YELLOW}Enter ${GREEN}load balance port${NC}${YELLOW} [This port will be used for tunnel]:${NC}") " stream_port

# kharej
read -e -p "$(echo -e "${YELLOW}Enter ${GREEN}kharej wireguard port${NC}${YELLOW} [This is your current wireguard port]:${NC}") " server_port

# number of ipv6
read -e -p "$(echo -e "${YELLOW}How many ${GREEN}IPv6 addresses${NC}${YELLOW} do you want for load balance? [Native Kharej IPV6s]:${NC}") " num_ipv6

    # weights
for ((i=0; i<num_ipv6; i++)); do
    read -e -p "$(echo -e "${YELLOW}Enter ${GREEN}Kharej IPv6 address${NC}${YELLOW} [Native ipv6s] $((i+1)):${NC}") " ipv6_address
    ipv6_addresses+=($ipv6_address)
    weights+=($((i+1)))
done
printf "\e[93m╰───────────────────────────────────────────────────────────╯\e[0m\n"
    # remove 
    rm /etc/nginx/nginx.conf

    # copy config
    echo "user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    include /etc/nginx/modules-enabled/*.conf;

    events {
        worker_connections 768;
        # multi_accept on;
    }

    http {
        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##


        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##

        gzip on;

        # gzip_vary on;
        # gzip_proxied any;
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        # gzip_http_version 1.1;
        # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

        ##
        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
    }" > /etc/nginx/nginx.conf

    # nginx config
    local nginx_conf="stream {
        upstream azumi_backend {
            least_conn;"

    for ((i=0; i<num_ipv6; i++)); do
        nginx_conf+="\n            server [${ipv6_addresses[$i]}]:${server_port} weight=${weights[$i]} fail_timeout=60s;"
    done

    nginx_conf+="\n        }

        server {
            listen ${stream_port} udp;
            proxy_pass azumi_backend;
        }
    }"

    # load balancing config
    echo -e "$nginx_conf" >> /etc/nginx/nginx.conf

    # test & restart
    display_notification $'\e[91mTesting nginx...\e[0m'
    nginx -t
    echo $'\e[93m════════════════════════════════════════\e[0m'
    display_notification $'\e[91mRestarting nginx...\e[0m'
    systemctl restart nginx
	systemctl enable nginx > /dev/null 2>&1

    display_checkmark $'\e[92mUDP loadbalance configuration completed\e[0m'
	message="$(echo -e "${GREEN}This loadbalancer port should be used for FRP & UDP2RAW tunnel, save it on a notepad >> [$stream_port]${NC}")"
	display_boxx "$message"
}
function kharej__frp_tunnel() {
  clear
  echo $'\e[92m ^ ^\e[0m'
  echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
  echo $'\e[92m(   ) \e[93mFRP Kharej Tunnel\e[0m'
  echo $'\e[92m "-"\e[93m═══════════════════════════════\e[0m'
  display_logoo
  echo -e "\e[93m.------------------------------------------------------------------------------------------------.\e[0m"
  echo -e "\e[93m| \e[92mUse loadbalance port instead of kharej wireguard port                                          \e[93m|\e[0m"
  echo -e "\e[93m| Iran wireguard port is your new wireguard port                                                 \e[93m|\e[0m"
  echo -e "\e[93m| \e[31mYour wireguard endpoint will be like : IPV4-IRAN : your iran wireguard port                    \e[93m|\e[0m"
  echo -e "\e[93m|\e[0m You can use native ipv6 or private ip address for tunnel. Use native ipv6 for loadbalance      \e[93m|\e[0m"
  echo -e "\e[93m'------------------------------------------------------------------------------------------------'\e[0m"
  display_notification $'\e[93mStarting FRP Wireguard tunnel...\e[0m'
  
   # Kharej IPv6 configuration
        printf "\e[93m╭────────────────────────────────────────────────────────────╮\e[0m\n"
        read -e -p $'\e[93mEnter \e[92mIran\e[93m IPv6 address [Private or Native]: \e[0m' server_addr
        read -e -p $'\e[93mEnter \e[92mKharej\e[93m IPv6 address [Private or Native]: \e[0m' local_ip
		
        read -e -p $'\e[93mEnter \e[92mtunnel\e[93m port [Same port: 443]: \e[0m' server_port
	
        read -e -p $'\e[93mEnter \e[92mToken\e[93m key [Same Password]: \e[0m' token
	
        read -e -p $'\e[93mEnter \e[92mLoadbalancer\e[93m port: \e[0m' local_port
		
        read -p $'\e[93mEnter \e[92mIran\e[93m Wireguard port [This is your new wireguard port]: \e[0m' remote_port
        printf "\e[93m╰────────────────────────────────────────────────────────────╯\e[0m\n"
		# frpc.ini 
rm frp_0.52.3_linux_amd64/frpc.ini
rm frp_0.52.3_linux_arm64/frpc.ini
# CPU architecture
if [[ "$(uname -m)" == "x86_64" ]]; then
  cpu_arch="amd64"
elif [[ "$(uname -m)" == "aarch64" ]]; then
  cpu_arch="arm64"
else
  echo -e "\e[93mUnsupported CPU architecture.\e[0m"
  exit 1
fi

# CPU architecture
config_file="/root/frp_0.52.3_linux_$cpu_arch/frpc.ini"

# frpc.ini
echo "[common]
server_addr = $server_addr
server_port = $server_port
token = $token

[wireguard]
type = udp
local_ip = $local_ip
local_port = $local_port
remote_port = $remote_port
use_encryption = true
use_compression = true" >> "$config_file"

# frpc service
service_file="/etc/systemd/system/azumifrpc.service"
echo "[Unit]
Description=frpc service
After=network.target

[Service]
ExecStart=/root/frp_0.52.3_linux_$cpu_arch/./frpc -c $config_file
Restart=always
User=root

[Install]
WantedBy=multi-user.target" | sudo tee "$service_file" &>/dev/null

    display_checkmark $'\e[92mKharej Wireguard Tunnel has been completed successfully!\e[0m \e[91mYours Truly, Azumi\e[0m'
      # additional commands for Kharej side
    sudo systemctl daemon-reload
    sudo systemctl enable azumifrpc
    sudo systemctl start azumifrpc
	display_loading
	display_checkmark $'\e[92mFRP Wireguard tunnel setup has been completed successfully!\e[0m'
}
function iran_frp_tunnel() {
# Iran configuration
    clear
    echo $'\e[92m ^ ^\e[0m'
    echo $'\e[92m(\e[91mO,O\e[92m)\e[0m'
    echo $'\e[92m(   ) \e[93mFRP Iran Tunnel\e[0m'
    echo $'\e[92m "-"\e[93m═══════════════════════════════\e[0m'
	display_logoo
    echo -e "\e[93m.------------------------------------------------------------------------------------------------.\e[0m"
    echo -e "\e[93m| \e[92mUse loadbalance port which you have saved on a notepad                                         \e[93m|\e[0m"
    echo -e "\e[93m| Iran wireguard port is your new wireguard port                                                 \e[93m|\e[0m"
    echo -e "\e[93m|\e[0m \e[33mYour wireguard endpoint will be like : IPV4-IRAN : your iran wireguard port                    \e[93m|\e[0m"
    echo -e "\e[93m'------------------------------------------------------------------------------------------------'\e[0m"
	printf "\e[93m╭──────────────────────────────────────────────────────╮\e[0m\n"
    read -e -p $'\e[33mEnter \e[92mtunnel\e[33m port [Same port : 443]: \e[0m' bind_port
	
    read -e -p $'\e[33mEnter your \e[92mToken key\e[33m [Same Password]: \e[0m' token
	
    read -e -p $'\e[33mEnter \e[92mIran\e[33m Wireguard port [This is your new wireguard port]: \e[0m' local_port
	
    read -e -p $'\e[33mEnter \e[92mloadbalancer\e[33m port: \e[0m' remote_port
	printf "\e[93m╰──────────────────────────────────────────────────────╯\e[0m\n"
  rm frp_0.52.3_linux_amd64/frps.ini
  rm frp_0.52.3_linux_arm64/frps.ini
    # frps.ini
	# CPU architecture
if [[ "$(uname -m)" == "x86_64" ]]; then
  cpu_arch="amd64"
elif [[ "$(uname -m)" == "aarch64" ]]; then
  cpu_arch="arm64"
else
  echo -e "\e[93mUnsupported CPU architecture.\e[0m"
  exit 1
fi

# CPU architecture
config_file="/root/frp_0.52.3_linux_$cpu_arch/frps.ini"

    echo "[common]
bind_port = $bind_port
token = $token

[wireguard]
type = udp
local_ip = 127.0.0.1
local_port = $local_port
remote_port = $remote_port
use_encryption = true
use_compression = true" >> "$config_file"

    # frps service
	service_file="/etc/systemd/system/azumifrps.service"
    echo "[Unit]
Description=frps service
After=network.target

[Service]
ExecStart=/root/frp_0.52.3_linux_$cpu_arch/./frps -c $config_file
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee "$service_file" &>/dev/null

    display_checkmark $'\e[92mIran Wireguard Tunnel has been completed successfully!\e[0m \e[91mYours Truly, Azumi\e[0m'
     # additional commands for Iran side
    sudo systemctl daemon-reload
    sudo systemctl enable azumifrps
    sudo systemctl start azumifrps
    display_loading
	display_checkmark $'\e[92mFRP Wireguard tunnel setup has been completed successfully!\e[0m'
}

function configure_load_balancing() {
    clear
# (Ctrl+C)
    trap stop_loading INT
 # ip forward
  sysctl -w net.ipv4.ip_forward=1 &>/dev/null
  sysctl -w net.ipv6.conf.all.forwarding=1 &>/dev/null

  # dns
  echo "nameserver 8.8.8.8" > /etc/resolv.conf

# IPv4 and IPv6
  sysctl -w net.ipv4.ip_forward=1 &>/dev/null
  sysctl -w net.ipv6.conf.all.forwarding=1 &>/dev/null

  # DNS baraye install
  echo "nameserver 8.8.8.8" > /etc/resolv.conf

  # download
  display_notification $'\e[91mPlease wait, updating...\e[0m'

  # start a timer.. heeey
  SECONDS=0

  # update in the background
  apt update &>/dev/null &
  apt_update_pid=$!
  apt install -y nginx &>/dev/null &


  # timer
  while [[ -n $(ps -p $apt_update_pid -o pid=) ]]; do
    clear
    display_notification $'\e[93mPlease wait, updating...\e[0m'
    display_notification $'\e[93mAzumi is Working in the background, timer: \e[0m'"$SECONDS seconds"
    sleep 1
  done

  # progress bar 
  for ((i=0; i<=10; i++)); do
    sleep 0.5
    display_progress 10 $i
  done

  display_checkmark $'\e[92mNginx installed successfully!\e[0m'

# sysctl setting
  sysctl -p &>/dev/null

  # Notification for sysctl and DNS changes
  display_notification $'\e[92mIP forward enabled!\e[0m'
  display_loading
# interrupt
    trap - INT

    sleep 1
    local stream_port=""
    local server_port=""
    local ipv6_addresses=()
    local weights=()
# loadbalance port
YELLOW='\e[93m'
GREEN='\e[92m'
NC='\e[0m'
display_logoo
    echo -e "\e[93m.--------------------------------------------------------------------------------------------------.\e[0m"
    echo -e "\e[93m| \e[92mEnter your loadbalance port, this will be used as your new wireguard port                        \e[93m|\e[0m"
    echo -e "\e[93m| \e[93mEnter your current wireguard port and select how many ipv6 do you need for the loadbalancer      \e[93m|\e[0m"
	echo -e "\e[93m| \e[0mKharej IPV6 should be native for this purpose                                                    \e[93m|\e[0m"
    echo -e "\e[93m'--------------------------------------------------------------------------------------------------'\e[0m"
	echo ""
printf "\e[93m╭───────────────────────────────────────────────────────────╮\e[0m\n"
read -e -p "$(echo -e "${YELLOW}Enter ${GREEN}load balance port${NC}${YELLOW} [This will be your new wireguard port]:${NC}") " stream_port
# kharej
read -e -p "$(echo -e "${YELLOW}Enter ${GREEN}kharej wireguard port${NC}${YELLOW} [This is your current wireguard port]:${NC}") " server_port
# number of ipv6
read -e -p "$(echo -e "${YELLOW}How many ${GREEN}IPv6 addresses${NC}${YELLOW} do you want for load balance? [Native Kharej IPV6s]:${NC}") " num_ipv6
    # weights
for ((i=0; i<num_ipv6; i++)); do
    read -e -p "$(echo -e "${YELLOW}Enter ${GREEN}Kharej IPv6 address${NC}${YELLOW} [Native ipv6s] $((i+1)):${NC}") " ipv6_address
    ipv6_addresses+=($ipv6_address)
    weights+=($((i+1)))
done
printf "\e[93m╰───────────────────────────────────────────────────────────╯\e[0m\n"
    # remove 
    rm /etc/nginx/nginx.conf

    # copy config
    echo "user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    include /etc/nginx/modules-enabled/*.conf;

    events {
        worker_connections 768;
        # multi_accept on;
    }

    http {
        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##


        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##

        gzip on;

        # gzip_vary on;
        # gzip_proxied any;
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        # gzip_http_version 1.1;
        # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

        ##
        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
    }" > /etc/nginx/nginx.conf

    # nginx config
    local nginx_conf="stream {
        upstream azumi_backend {
            least_conn;"

    for ((i=0; i<num_ipv6; i++)); do
        nginx_conf+="\n            server [${ipv6_addresses[$i]}]:${server_port} weight=${weights[$i]} fail_timeout=60s;"
    done

    nginx_conf+="\n        }

        server {
            listen ${stream_port} udp;
            proxy_pass azumi_backend;
        }
    }"

    # load balance config
    echo -e "$nginx_conf" >> /etc/nginx/nginx.conf

    # test 
    display_notification $'\e[91mTesting nginx...\e[0m'
    nginx -t
    echo $'\e[93m════════════════════════════════════════\e[0m'
    display_notification $'\e[91mRestarting nginx...\e[0m'
    systemctl restart nginx
	systemctl enable nginx > /dev/null 2>&1

    display_checkmark $'\e[92mUDP loadbalance configuration completed\e[0m'
	message="$(echo -e "${GREEN}This loadbalancer port is your new wireguard port>> [$stream_port]${NC}")"
    display_boxx "$message"
}

# Call the main_menu function
main_menu

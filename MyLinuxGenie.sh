#!bin/bash
#-----COLOR LIST-----
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NON='\033[0m'
ORANGE='\033[38;5;208m' 
LOG="linux_bash.log"
VERSON="1.0.0"
#----- display Header -----
display_header(){
clear 
echo -e " ${YELLOW} \t\t\t   Welcome To My First App :) "
echo -e "${CYAN}"
echo -e "\t\t\t╔════════════════════════════════════╗"
echo -e "\t\t\t║        Linux Helper Assistant      ║"
echo -e "\t\t\t║           Version $VERSON            ║"
echo -e "\t\t\t╚════════════════════════════════════╝"
echo -e "${NON}"

}
log_time(){
echo "The Date and Time is: $(date '+%Y-%m-%d %H:%M:%S' )-$1">>"$LOG"
}

handle_errors() {
  local func_name=$1
  local error_msg=$2
  echo -e "${RED}Error occurred in function $func_name: $error_msg${NON}"
  log_time "Error in function $func_name - $error_msg"
  read -p "Press Enter to continue..."
}
check_root() {
  if [[ $EUID -eq 0 ]]; then
    echo -e "${RED}Error: This script should not be run as root!${NON}"
    exit 1
  fi
}

system_health() {
    echo -e "\n${BLUE}=== System Health ===${NON}"
    
    #CPU
    cpu_load=$(top -bn1 | grep load | awk '{printf "%.2f%%", $(NF-2)}')|| {
    handle_errors "system_health" "Failed to get CPU load"
    return 1 
    }
    echo -e "${YELLOW}CPU Load:${NON} $cpu_load"
    
    # Memory 
    memory_usage=$(free -m | awk '/Mem/{printf "%.2f%%", $3/$2*100}')|| {
    handle_errors "system_health" "Failed to get memory usage"
    return 1
  }
    echo -e "${YELLOW}Memory Usage:${NON} $memory_usage"
    
    # Storage Space
    storage_free=$(df -h / | awk '/\//{print $4}')|| {
    handle_errors "system_health" "Failed to get storage info"
    return 1
  }
    echo -e "${YELLOW}Storage Free:${NON} $storage_free"
    
    log_time "Checked system health"

}
system_update(){
   	
	echo -e "\n${Blue}=== System Update === ${NON}"
	if ! command -v apt &> /dev/null; then 
	    echo -e "${RED}Error: This is works only on Debian :( ${NON}"
	    return 1
	fi
	
	read -p "Are You Sure To Update The System [Y/N]: " check
	if [[ "$check" =~ ^[Yy]$ ]]; then
	   sudo apt update && sudo apt full-upgrade -y || {
      		handle_errors "system_update" "Failed to update system"
      		return 1
      		}
	log_time "System update complete :)"
	else 
	   echo -e "${YELLOW}Update canceled${NON}"
	fi 

}





#-------History-------
history_command(){
	touch ~/Downloads/history.txt
  echo -e "\n${BLUE}=== History Command  ===${NON}"
  
    HISTORY_FILE="$HOME/Downloads/history.txt"
    history -a
    {
     cat ~/.bash_history
    }  > "$HISTORY_FILE" || {
    handle_errors "history_command" "Failed to save history to {YELLOW}$HISTORY_FILE 
    ${NON}"
    return 1
  }
  
      echo -e "${GREEN}history saved to:${NON} ${YELLOW}$HISTORY_FILE${NON}"
       echo -e "\n${CYAN}Last 10 commands:${NON}"
  tail -n 10 "$HISTORY_FILE"
     
      read -p "Do You Want to Open With gedit [Y/N]?" OPEN
      [[ "$OPEN" =~ ^[Yy]$ ]]&& gedit "$HISTORY_FILE" &
 
  
  log_time "Saved and viewed command history"
}




#-------Youtube_Download ---------
youtube_download(){
   echo -e "\n${BLUE}=== YouTube Video Download ===${NON}"
   
   if ! command -v yt-dlp &> /dev/null; then
    echo -e "${YELLOW}Installing yt-dlp...${NON}"
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
  fi
  if ! command -v ffmpeg &> /dev/null; then
    echo -e "${YELLOW}Installing ffmpeg...${NON}"
    sudo apt update && sudo apt install -y ffmpeg || {
        handle_errors "youtube_download" "Failed to install ffmpeg"
        return 1
    }
   fi
  
DOWNLOAD_Folder="$HOME/Downloads/YT_downloads"
  mkdir -p "$DOWNLOAD_Folder"
  
  echo -e "${CYAN}Select Quality:${NON}"
  echo "1. Best Quality (Default)"
  echo "2. 1080p"
  echo "3. 720p"
  echo "4. 480p"
  echo "5. 360p"
  echo "6. Audio Only"
  read -p "$(echo -e ${ORANGE}Enter quality choice [1--6]: ${NON})" quality_choice
if [[ $quality_choice == 1 ]]; then 
   		FORMAT="bestvideo[height<=2160]+bestaudio/best"
   	elif [[ $quality_choice == 2 ]]; then 
   		FORMAT="bestvideo[height<=1080]+bestaudio/best"
   	elif [[ $quality_choice == 3 ]]; then 
   		FORMAT="bestvideo[height<=720]+bestaudio/best"
   	elif [[ $quality_choice == 4 ]]; then 
   		FORMAT="bestvideo[height<=480]+bestaudio/best"
     	elif [[ $quality_choice == 5 ]]; then 
     		FORMAT="bestvideo[height<=360]+bestaudio/best"
     	else 
     		FORMAT="bestaudio/best"
	fi
	
	read -p "Enter YouTube URL or Playlist URL: " url
  if [[ -z "$url" ]]; then
    handle_errors "youtube_download" "Empty URL provided"
    return 1
  fi
      echo -e "${GREEN}Downloading...${NON}"
  yt-dlp -o "$DOWNLOAD_Folder/%(title)s.%(ext)s" \
    -f "$FORMAT" \
    --embed-thumbnail \
    --add-metadata \
    "$url" || {
    handle_errors "youtube_download" "Failed to download content :)"
    return 1
  }
  echo -e "${GREEN}Download completed! Files saved to Path:${NON} ${YELLOW}$DOWNLOAD_Folder${NON}"

  log_time "Downloaded YouTube content from $url"
}





#-------Game-------
number_game(){
echo -e "\n${CYAN}=== Number Guessing Game ===${NON}"
echo -e "\n ${RED}Be careful if you Make mistakes here, your File Will Go HAHAHAHAHAHAHAHA :)${NON}"
  secret=$((RANDOM %15 +1))
  for number in {1..3}; do
   read -p "Attempt $number/3 -Guess (1-15): " guess 
 if [[ ! "$guess" =~ ^[0-9]+$ ]] || (( guess < 1 || guess > 15 )); then
      echo -e "${RED}Numbers only please!${NON}"
      continue
    fi
    if (( guess == secret )); then
      echo -e "${GREEN}Congratulations! You won! ...The Number is $secret ${NON}"
      log_time "Won number game ${secret}"
      return
       elif (( guess < secret )); then
      echo "Try higher!"
    else
      echo "Try lower!"
    fi
  done
    echo -e "${RED}Game over! The number was $secret ${NON}"
  echo -e "\n${RED}☠️  Wrong answer! Initiating system restart...${NON}"
  
echo -e "\n${RED}⚠️  CRITICAL SYSTEM FAILURE! REBOOTING...${NON}"
log_time "Initiating real system restart"
sleep 2
shutdown -r now
  
  
  
}






#------- Menu -------
main_menu(){
while true ; do 
    display_header 
    echo -e "${YELLOW}Main Menu:${NON}"
    echo "1. System Health Check"
    echo "2. System Update"
    echo "3. history_command"
    echo "4. Number Game"
    echo "5. YouTube Download"
    echo "6. View Logs"
    echo "7. Exit"
	
 read -p "$(echo -e ${GREEN}Enter choice [1 -- 7] : ${NON})" choice
   	if [[ $choice == 1 ]]; then 
   		system_health
   	elif [[ $choice == 2 ]]; then 
   		system_update
   	elif [[ $choice == 3 ]]; then 
   		history_command
   	elif [[ $choice == 4 ]]; then 
   		number_game
     	elif [[ $choice == 5 ]]; then 
     		youtube_download
     	elif [[ $choice  == 6 ]]; then 
     		less "$LOG"
     	elif [[ $choice  == 7 ]]; then 
     		exit 0
	else
     	 echo -e "${RED}The Number is no Found :(! ${NON}" 
     	 sleep 1 
    fi
      read -p "Press Enter to continue.... :) "
   done 
}

check_root
touch "$LOG"


display_header 
echo -e "${GREEN}Welcome to Linux Bash!${NON}"
sleep 1
main_menu




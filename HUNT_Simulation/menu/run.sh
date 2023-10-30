#!/bin/bash
show_menu(){
    normal="\033[m"
    menu="\033[36m" #Blue
    number="\033[33m" #yellow
    fggreen="\e[92m"
    fgred="\033[31m"

    version="1.0"

    mitems=(
           "Medium -$fggreen Container Drift via File Creation and Execution [EDR]"
           "Medium -$fggreen Defense Evasion via Masquerading [EDR]"
           "Critical -$fggreen Defense Evasion via Rootkit [EDR]"
           "High -$fggreen Execution via Command-Line Interface [EDR]"
           "High -$fggreen Exfiltration Over Alternative Protocol [EDR]"
           "High -$fggreen Command & Control via Remote Access Tools [EDR]"
           "High -$fggreen Collection via Automated Collection [EDR]"
           "High -$fggreen Persistance via External Remote Services [EDR]"
	   "High -$fggreen Request to DNS CanaryToken [AWS]"
	   "High -$fggreen Command & Control GuardDuty [AWS]"
	   "Critical -$fggreen Resource Hiajack via Bitcoin wallet [AWS]"
	   "High -$fggreen Exfiltration Over Alternative Protocol GuardDuty [AWS]"
	   "Low -$fggreen Download EICAR files [AWS]"
	   "Low -$fggreen Generating EICAR files [AWS]"
	   "High -$fggreen Request to Onion node [AWS]"
	   "High -$fggreen Exfiltration using Bash shell [Linux]"
	   "High -$fggreen Exfiltration using Cancel command [Linux]"
	   "High -$fggreen Exfiltration using Busybox command [Linux]"
	   "High -$fggreen Exfiltration using Whois command [Linux]"
	   "High -$fggreen Exfiltration using Wget command [Linux]"
	   "High -$fggreen Exifiltration using Curl command [Linux]"
           )

    edir='../bin/'

    eitems=(
           "ContainerDrift_Via_File_Creation_and_Execution.sh"
           "Defense_Evasion_via_Masquerading.sh"
           "Defense_Evasion_via_Rootkit.sh"
           "Execution_via_Command-Line_Interface.sh"
           "Exfiltration_via_Exfiltration_Over_Alternative_Protocol.sh > /dev/null 2>&1"
           "Command_Control_via_Remote_Access.sh"
           "Collection_via_Automated_Collection.sh"
           "Persistence_via_External_Remote_Services.sh"
           "Command_Control_via_DNS_CanaryToken.sh"
	   "Command_Control_GuardDuty.sh"
           "Impact_Resource_Hijacking_BitCoin_Wallet.sh"
	   "Exfiltration_via_Exfiltration_GuardDuty.sh"
	   "Execution_UserExecution_MaliciousFile_EICAR.sh"
	   "Execution_UserExecution_Generated_EICAR.sh"
	   "Command_Control_Onion.sh"
	   "Exfiltration_via_bash.sh"
	   "Exfiltration_via_cancel.sh"
	   "Exfiltration_via_busybox.sh"
	   "Exfiltration_via_whois.sh"
	   "Exfiltration_via_wget.sh"
	   "Exfiltration_via_curl.sh"
           )

    numitems=${#mitems[@]}

    printf "${fgred}V${version}${normal}\n"


echo "██████  ███████ ████████ ███████  ██████ ████████ ██  ██████  ███    ██ ████████  ██████   ██████  ██      ";
echo "██   ██ ██         ██    ██      ██         ██    ██ ██    ██ ████   ██    ██    ██    ██ ██    ██ ██      ";
echo "██   ██ █████      ██    █████   ██         ██    ██ ██    ██ ██ ██  ██    ██    ██    ██ ██    ██ ██      ";
echo "██   ██ ██         ██    ██      ██         ██    ██ ██    ██ ██  ██ ██    ██    ██    ██ ██    ██ ██      ";
echo "██████  ███████    ██    ███████  ██████    ██    ██  ██████  ██   ████    ██     ██████   ██████  ███████ ";
echo "                                                                                                           ";
echo "by CSIRT/UCI                                                                                                           ";


    printf "\n${menu}     Select one of the following TTPs${normal}\n"
    printf "\n${menu}*********************************************${normal}\n"

    for (( i=1; i<=numitems; i++ ))
    do
        j=$((i - 1))
        printf "${menu}**${number} ${i})${menu} ${mitems[$j]} ${normal}\n"
    done

    printf "\n"
    printf "${menu}**${number} a)${menu} Automatically run random scripts${normal}\n"
    printf "${menu}**${number} o)${menu} Generate Severity test detection${normal}\n"
    printf "\n"
    printf "${menu}**${number} e)${menu} Exit to Container shell${normal}\n"
    printf "${menu}**${number} x)${menu} Exit Container${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please enter a menu option and enter: "
    read opt
}

after_exec(){
    read -p "Press enter to continue";
    clear;
    show_menu;
}

option_picked(){
    msgcolor="\033[01;31m" # bold red
    normal="\033[00;00m" # normal white
    message=${*:-"${normal}Error: No message passed"}
    printf "${msgcolor}${message}${normal}\n"
}

validate_numerical_option(){
    # checks if $opt is a valid numerical option (if numerical)
    [[ $1 =~ ^[0-9]+$ ]] && [[ $1 -le $numitems && $1 -ge 1 ]]
}

clear
show_menu
while true
do
    if [ "$opt" = '' ]; then
        exit;
    else
        # Handle numerical options
        if validate_numerical_option "$opt"; then
            clear;
            m=$opt-1
            option_picked "$opt - ${mitems[$m]}"
            $edir${eitems[$m]};
            after_exec;
        else
            case $opt in
                a)
                    clear;
                    option_picked "This script will automatically generate random events at ransom interval (30 minutes max). Type <Ctrl-C> to return to menu";
                    ../menu/auto;
                    show_menu;
                ;;

                o)
                    clear;
                    option_picked "This menu will create a Severity test detection";
                    ../menu/ow;
                    clear;
                    show_menu;
                ;;

                e)
                    clear;
                    option_picked "Type exit to return to menu";
                    /bin/bash;
                    show_menu;
                ;;

                x|q)
                    exit;
                ;;

                '\n')
                    exit;
                ;;

                *)
                    option_picked "Pick a valid option from the menu";
                    show_menu;
                ;;
            esac
        fi
    fi
done

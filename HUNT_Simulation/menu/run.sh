#!/bin/bash
show_menu(){
    normal="\033[m"
    menu="\033[36m" #Blue
    number="\033[33m" #yellow
    fggreen="\e[92m"
    fgred="\033[31m"

    version="1.0"

    mitems=(
           "Medium - Container Drift via File Creation and Execution"
           "Medium - Defense Evasion via Masquerading"
           "Critical - Defense Evasion via Rootkit"
           "High - Execution via Command-Line Interface"
           "High - Exfiltration Over Alternative Protocol"
           "High -$fggreen Command & Control via Remote Access Tools"
           "High - Collection via Automated Collection"
           "High -$fggreen Persistance via External Remote Services"
	   "High - Request to DNS CanaryToken"
	   "High -$fggreen Command & Control GuardDuty"
	   "Critical - Resource Hiajack via Bitcoin wallet"
	   "High - Exfiltration Over Alternative Protocol GuardDuty"
	   "Low - Download EICAR files"
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

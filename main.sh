source fonctions.sh

case $1 in
        -l)	iwlist wlp3s0 scan | grep SSID ;;	
	-lsort) iwlist wlp3s0 scan | egrep "signal:|SSID:" | sort -u ;;
        -d)	service network-manager stop;;
	-h)	printf "Usage :\n -l To check wifi list \n -lsort Wifi list sorted by intensity signal \n -d to deactivate network manager \n -connect to connect to a choosen wifi \n  " ;;
        -connect)
        	connect ;;
	-dia) 	dia ;;	
	*)	menu_principale ;;

esac 


menu_principale()
{
x=4
while (($x!=0))
do
echo "               B I E N V E N U E                    "
echo "----------------------------------------------------"
echo "1-List des AP : "
echo "2-configuration : "
echo "3-help"
echo "0-Quitter !"
echo "----------------------------------------------------"
echo "entrez votre choix : "
read choix
case $choix in
1)
   menu_list ;;
2)
   menu_config ;;
3)
   helps ;;
0)
x=0 ;;
esac 
done
}
menu_list()
{
echo "              M E N U * L I S T                   "
echo "----------------------------------------------------"
echo "1-Liste: "
echo "2-liste avec tri : "
echo "----------------------------------------------------"
echo "entrez votre choix : "
read choix
case $choix in
1)
   iwlist wlp3s0 scan | grep SSID ;;
2)
   iwlist wlp3s0 scan | egrep "signal:|SSID:" | sort -u ;;

esac 

}
menu_config()
{
echo "              M E N U * C O N F I G                   "
echo "----------------------------------------------------"
echo "1-deactivate network manager: "
echo "2-connect to connect to a choosen wifi : "
echo "----------------------------------------------------"
echo "entrez votre choix : "
read choix
case $choix in
1)
   service network-manager stop ;;
2)
   connect ;;

esac 

}
helps()
{
        printf "Usage :\n -l To check wifi list \n -lsort Wifi list sorted by intensity signal \n -d to deactivate network manager \n -connect to connect to a choosen wifi \n  "
}

dia()
{
DIALOG=${DIALOG=dialog}
fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
trap "rm -f $fichtemp" 0 1 2 5 15
$DIALOG --clear --title "Sujet-20" \
	--menu " choisissez votre commande  :" 20 51 4 \
	 "-l" " " \
	 "-lsort" " " \
 	 "-d" " " \
	 "-h" " " \
	 "-connect" " " \
	 "*" " " 2> $fichtemp
valret=$?
choix=`cat $fichtemp`
case $valret in
 0)	 case $choix in
        -l)
          iwlist wlp3s0 scan | grep SSID 
	
        ;;
        -lsort)
        iwlist wlp3s0 scan | egrep "signal:|SSID:" | sort -u
        ;;
        -d)
        service network-manager stop
        ;;
	-h)
        printf "Usage :\n -l To check wifi list \n -lsort Wifi list sorted by intensity signal \n -d to deactivate network manager \n -connect to connect to a choosen wifi \n  "
        ;;
        -connect)
        connect
        ;;
        *)
        ;;
    esac
;;
 1) 	echo "Appuyé sur Annuler.";;
255) 	echo "Appuyé sur Echap.";;
esac
}
connect()
{
echo "wifi name"
read x
echo "password"
read y
nmcli dev wifi connect $x password $y
}

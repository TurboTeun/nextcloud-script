 #!/bin/sh


#====================================== webserver =================================================
 
#rsync -av /home/admin/desktop/nginxconf.txt /etc/nginx/sites-available/$domein.conf

#sudo password = P@ssw0rd
echo "hallo" 
while true 

do 

    echo "Welke webserver wilt u installeren apache/nginx?"     #je hebt de optie tussen apache en nginx
    read apache

        if [ $apache = "apache" ]                           #if statement om apache te kunnen installeren
 
            then
            sudo zypper install apache2
            zypper info apache2

            elif [ $apache = "nginx" ]                      #if statement om nginx te kunnen installeren

 
            then 
            sudo zypper install nginx 
            zypper info nginx
        fi                                                  #hier eindigt het if statement
 
            echo "Wilt u het script voor webserver opnieuw laden? j/n"  
                                                            # hier heb je de keuze om het webserver script opnieuw te kunnen runnen
            read e

        [ $e = "n" ] && break                               #als je het script niet opnieuw wilt laden dan gaat hij verder met het script


done

#====================================== nextcloud ================================================= 

while true

do 


    echo 'Vul  hier uw domein naam in'                      #je kunt hier het domein kiezen om je nextcloud omgeving te kunnen configureren
    
    read domeinnaam
  

  
        wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
        unzip nextcloud-21.0.2.zip -d /home/admin/Desktop/nextcloud.zip

        unzip /home/admin/Desktop/nextcloud.zip /home/admin/Desktop/$domeinnaam
 
        echo "Voor het configureren van nextcloud, kunt u hier op klikken* "https://"$domeinnaam"


        echo "Wilt u het script van nextcloud opnieuw laden? j/n"
        read e                                              #als de installatie mislukt is kun je die opnieuw runnen

    [ $e = "n" ] && break

done
    
#====================================== fail2ban ==================================================
    
while true

do

    while true                                              
    
    #2 while loops in elkaar zodat je fail2ban opnieuw kunt installeren als je dit opnieuw wilt doen of er iets fout gegaan is

    do

        echo "."
        echo 'wilt u fail2ban installeren? j/n'
        echo 'als fail2ban al geinstalleerd is druk dan op n'
        read i
        [ $i = "n" ] && break                               
        
        #als je fail2ban niet wilt installeren dan breakt hij deze while loop en gaat hij naar de volgende of je het opnieuw wilt installeren

            sudo apt-get install -y fail2ban
            sudo systemctl start fail2ban
            sudo systemctl enable fail2ban
            echo "wilt u een jail configureren j/n?"
            read jail
 
        if [ $jail = "j" ] 
 
        then
            sudo nano /etc/fail2ban/jail.local              #hier kunnen we de jail configureren
    
            [sshd]
            enabled = true
            port = 22
            filter = sshd
            logpath = /var/log/auth.log
            maxretry = 5
    
        fi
    
       
    done
         
        echo "Wilt u het script fail2ban opnieuw laden? j/n"    #hier kun je opnieuw het script laden 
        echo 'als fail2ban al geinstalleerd is druk dan nog eens op n'
        read e
        [ $e = "n" ] && break
done

#====================================== https =====================================================

while true                                                  #we gaan let's encrypt installeren

do


    echo "Welke webserver heeft u geinstalleerd apache/nginx?"     #je moet aangeven welke webserver je hebt geinstalleerd voor de https
    read apache

        if [ $apache = "apache" ]                           #if statement om https van apache te installeren
 
            then
            sudo zypper install certbot python-certbot python-certbot-apache
            

            elif [ $apache = "nginx" ]                      #if statement om https van nginx te installeren

 
            then 
            sudo zypper install certbot python-certbot python-certbot-nginx

        fi                                                  #hier eindigt het if statement
 
            echo "Wilt u het script voor voor https opnieuw laden? j/n"  
                                                            # hier heb je de keuze om het https script opnieuw te kunnen runnen
            read e

        [ $e = "n" ] && break                               #als je het script niet opnieuw wilt laden dan gaat hij verder met het script


done


#====================================== firewall ==================================================

while true

do 

    echo "wilt u een firewall installeren? j/n"             #hier installeren we de firewall
    read firewall

        if [ $firewall = "j" ]

        then 

            sudo zypper install firewalld
            sudo systemctl enable firewalld                 #hij wordt meteen aangezet
            sudo systemctl start firewalld                  #en de firewall word meteen gestart
            sudo systemctl status firewalld                 #en je kunt meteen de status zien


        fi
        
    echo "Wilt u het script voor de firewall opnieuw laden? j/n"
    read e
    
    [ $e = "n" ] && break

done 

#====================================== einde installatie =========================================

echo " "
echo "de installatie is afgerond!"
echo "script gemaakt door Lars Teunissen"

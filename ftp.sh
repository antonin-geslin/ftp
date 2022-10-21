
#mise a jour des paquets
apt-get update -y
apt-get upgrade -y
#installation de proftpd
apt-get install proftpd-* -y

#instalation de SSL
apt-get install openssl -y

#création d'utilisateur
echo -ne "kalimac\nkalimac\n" | adduser merry
echo -ne "secondbreakfast\nsecondbreakfast\n" | adduser pippin 

#création du dossier ssl
mkdir /etc/proftpd/ssl

#génération des clés ssl
echo -ne "\n\n\n\n\n\n\n" | openssl req -new -x509 -days 365 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem -keyout /etc/proftpd/ssl/proftpd.key.pem

#changement des droits pour la clé privée
chmod 0640 /etc/proftpd/ssl/proftpd.key.pem


#configuration du fichier module.conf avec un lien
ln -sf /ftp/modules_link.conf /etc/proftpd/modules.conf

#configuration du fichier tls.conf avec un lien
ln -sf /ftp/tls_link.conf /etc/proftpd/tls.conf

#cconfiguration du fichier proftpd.conf avec un lien
ln -sf /ftp/proftpd_link.conf /etc/proftpd/proftpd.conf

#demarrage auto
sustemctl enable proftpd
#redémarrage du serveur ftp
systemctl restart proftpd
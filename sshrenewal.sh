#Define variables
$DOMAIN = $1;
$SERVICE_NAME = $2;

#Renew certificate
sudo certbot renew --force-renew
#Restart nginx
sudo nginx -s stop
sudo nginx
#Copy the script for microservice
sudo cd /etc/letsencrypt/live/$DOMAIN
sudo openssl pkcs12 -export -in /etc/letsencrypt/live/$DOMAIN/fullchain.pem -inkey /etc/letsencrypt/live/$DOMAIN/privkey.pem -out /etc/letsencrypt/live/$DOMAIN/keystore.p12 -name tomcat -CAfile /etc/letsencrypt/live/$DOMAIN/chain.pem -caname root
# Restart microservice
systemctl restart $2
#sudo keytool -genkey -alias mqtt-server -keysize 2048 -keyalg RSA -keystore ./server-keystore.jks

sudo keytool -genkey -alias mqtt-server -keysize 2048 -keyalg RSA -keystore ./server-keystore.jks -ext SAN=dns:localhost,ip:192.168.1.24


sudo keytool -export -alias mqtt-server -keystore ./server-keystore.jks -file ./server_public.crt

sudo openssl x509 -in ./server_public.crt -out ./server_public.pem -outform PEM

# not necessary
keytool -import -alias mule-client-public -keystore ./client-truststore.jks -file ./server_public.crt


///// FOr mosquitto
// This does not publish
mosquitto_pub -h 192.168.1.24 -t "test" -m "{message: "linux"}" -p 8883 -u mossuser -P mosspass --cafile /var/lib/my-broker/etc/server_public.pem


// This is subscriber
mosquitto_sub -t "test/#" -v -h 192.168.1.24 -p 1883 -u testuser -P testpassword

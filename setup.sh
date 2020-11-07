cd srcs

#Minikube starting
minikube start
eval $(minikube docker-env)

#Metallb
minikube addons enable metallb
kubectl apply -f metallb/metallb-config.yaml

#SSL keys generation
mkdir ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/test.key -out ssl/test.crt -subj "/C=RF/ST=Moscow/L=Moscow/O=21school/OU=ft_services/CN=test.com"
cp ssl/test.crt ftps/test.crt
cp ssl/test.key ftps/test.key
cp ssl/test.crt nginx/test.crt
cp ssl/test.key nginx/test.key

#SHH key generation and copy key.pub file
rm -f ~/.ssh/id_rbeachserver
rm -f ~/.ssh/id_rbeachserver.pub
ssh-keygen -f ~/.ssh/known_hosts -R "172.17.0.10"
ssh-keygen -t ecdsa -b 521 -C "test@172.17.0.10-$(date -I)" -f ~/.ssh/id_rbeachserver -N ''
cp ~/.ssh/id_rbeachserver.pub ./nginx/id_rbeachserver.pub

#Graphana deployment
cd grafana/influxdb
docker build --tag influxdb_img .
kubectl create secret generic influxdb-creds \
  --from-literal=INFLUXDB_DATABASE=k8s_monitoring \
  --from-literal=INFLUXDB_USERNAME=admin \
  --from-literal=INFLUXDB_PASSWORD=12345678 \
  --from-literal=INFLUXDB_HOST=influxdb
kubectl apply -f influxdb.yaml
cd ../telegraf
docker build --tag telegraf_img .
kubectl apply -f telegraf.yaml
cd ..
docker build --tag grafana_img .
kubectl create secret generic grafana-creds \
  --from-literal=GF_SECURITY_ADMIN_USER=admin \
  --from-literal=GF_SECURITY_ADMIN_PASSWORD=12345678
kubectl apply -f grafana.yaml
cd ..

#Nginx deployment
cd nginx
docker build --tag nginx_img .
kubectl apply -f nginx.yaml
cd ..

#Ftps deployment
cd ftps
docker build --tag ftps_img .
kubectl apply -f ftps.yaml
cd ..

#MariaDB deployment
cd wordpress/mariadb
docker build --tag mariadb_img .
kubectl apply -f mariadb.yaml
cd ../..

#Wordpress deployment
cd wordpress
docker build --tag wordpress_img .
kubectl apply -f wordpress.yaml
cd ..

#Phpmyadmin deployment
cd phpmyadmin
docker build --tag phpmyadmin_img .
kubectl apply -f phpmyadmin.yaml
cd ..

#Delete unnecessary files
rm -rf ssl
rm -f ftps/test.crt
rm -f ftps/test.key
rm -f nginx/id_rbeachserver.pub
rm -f nginx/test.crt
rm -f nginx/test.key

#Notices
echo "-------------------------------------------------------------------------------------------------"
echo "NGINX"
echo "https://172.17.0.10"
echo "For nginx logging by SSH enter 'ssh test@172.17.0.10'"
echo "-------------------------------------------------------------------------------------------------"
echo "For FTPS access use login 'test' without password and TLS support FTP software (e. g. Filezilla)"
echo "ftp://172.17.0.10:21"
echo "-------------------------------------------------------------------------------------------------"
echo "MYSQL admin:123"
echo "http://172.17.0.10:3306"
echo "-------------------------------------------------------------------------------------------------"
echo "Wordpress admin:123"
echo "http://172.17.0.10:5050"
echo "http://172.17.0.10/wordpress"
echo "-------------------------------------------------------------------------------------------------"
echo "Phpmyadmin admin:123"
echo "http://172.17.0.10:5000"
echo "http://172.17.0.10/phpmyadmin"
echo "-------------------------------------------------------------------------------------------------"
echo "InfluxDB admin:12345678"
echo "http://172.17.0.10:8086"
echo "-------------------------------------------------------------------------------------------------"
echo "Grafana admin:12345678"
echo "http://172.17.0.10:3000"
echo "-------------------------------------------------------------------------------------------------"

#Dashboard
minikube dashboard

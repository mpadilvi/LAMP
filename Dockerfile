FROM debian:latest
RUN apt update && apt upgrade -y &&\
apt install -y apache2 php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-gd php7.0-opcache mysql-server 
CMD mysqladmin password '' &&\ mysql_secure_installation -u root -p '' &&\
mysqladmin processlist -u root -p ''
WORKDIR /etc/apache2/conf-enabled
RUN echo "ServerSignature Off" >> security.conf && echo "ServerTokens Prod" >> security.conf 
WORKDIR /var
CMD mkdir www 
WORKDIR /var/www
CMD mkdir cdmon
WORKDIR /etc/apache2/sites-enabled
RUN sed -i 's+ DocumentRoot /var/www/html + DocumentRoot /var/www/cdmon + g' 000-default.conf
WORKDIR /tmp
CMD wget https://wordpress.org/latest.tar.gz &&\
tar -xvf latest.tar.gz &&\
mv wordpress /var/www/cdmon/
EXPOSE 80
WORKDIR /var/www/cdmon
CMD apachectl -D FOREGROUND


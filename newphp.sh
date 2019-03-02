#!/bin/bash
echo "You are about to create new php project"
echo "Please choose PHP Framework"
echo "1 - Laravel"
echo "2 - Codeigniter 3.^"
echo "3 - Codeigniter 4.^"

read -p "Number: " FRAMEWORK

if [ "$FRAMEWORK" == 1 ]
  then
    read -p "Enable auth? y/n: " AUTH
fi

echo "You've chosen $FRAMEWORK"

read -p "Project name: " NAME


echo "Setting up Virtual Host..."

CONF_FILE="/etc/apache2/sites-available/$NAME.test.conf"
touch $CONF_FILE
chmod +w $CONF_FILE

case "$FRAMEWORK" in
  [1])
    echo "<Directory /var/www/html/$NAME/public>
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
<VirtualHost *:80>
  ServerName $NAME.test
  ServerAlias www.$NAME.test
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html/$NAME/public
</VirtualHost>" > $CONF_FILE
    composer create-project --prefer-dist laravel/laravel /var/www/html/$NAME && echo 1234 | chmod -R 777 /var/www/html/$NAME/storage && chmod -R 888 /var/www/html/$NAME/bootstrap/cache
    case "$AUTH" in
      [yY] | [yY][eE][sS])
        php /var/www/html/$NAME/artisan make:auth
        ;;
      *)
    esac
    ;;
  [2])
    echo "<Directory /var/www/html/$NAME>
  Options Indexes FollowSymLinks MultiViews
  AllowOverride All
  Order allow,deny
  allow from all
  Require all granted
</Directory>
<VirtualHost *:80>
  ServerName $NAME.test
  ServerAlias www.$NAME.test
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html/$NAME
</VirtualHost>" > $CONF_FILE
    git clone https://github.com/bcit-ci/CodeIgniter.git /var/www/html/$NAME
    ;;
  [3])
    echo "<Directory /var/www/html/$NAME>
  Options Indexes FollowSymLinks MultiViews
  AllowOverride All
  Order allow,deny
  allow from all
  Require all granted
</Directory>
<VirtualHost *:80>
  ServerName $NAME.test
  ServerAlias www.$NAME.test
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html/$NAME
</VirtualHost>" > $CONF_FILE
    git clone https://github.com/codeigniter4/CodeIgniter4.git /var/www/html/$NAME
    ;;
  *)
esac

sudo a2ensite $NAME.test
sudo systemctl restart apache2
sed -i "1i127.0.0.1   $NAME.test" /etc/hosts

echo "Done..."
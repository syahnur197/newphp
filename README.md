# newphp
Linux bash script to create new php framework project (Laravel, CI3, CI4) and automatically add Virtual Host

## Requirements
- Apache2
- PHP (and its modules)

Please ensure that you have the permission to write `/var/www/html`

You also need to have permission to write 
    * `/home/${your user name}/.composer/cache/repo/https---packagist.org/,`
    * `/home/${your user name}/.composer/cache/files/`

This script does the followings:-
    - git clone / composer install php frameworks
    - Set up virtual host
    - Set up virtual host dns locally in `/etc/hosts`
    - Restart apache2
    - you can visit your website at `your_project_name.test` in your browser

## todo
    - Add several PHP Frameworks
    - Add Wordpress
    - Create MySQL DB for the projects

# Docker make symfony

Symfony dev without php, mysql and no nginx in your computer.

###### Prerequisite
 - Docker.
 - Git and Nothing else.
 - For the best experience you need to install the make command.

###### Install
- `git clone https://github.com/okhachiai/symfony-docker.git`
- `make build` or `docker-compose build --no-cache`
- `make start` or `docker-compose up`
- `make symfony` or `docker-compose exec phpfpm symfony new . -q`

Go to your browser http://localhost you should see a fresh installation of symfony.

###### Database
To manage your to your browser http://localhost:8888
- System :  Select `_MySQL_`
- Server : `_db_`
- Username : `_application_`
- Password : `_application_`
- Database : `_application_`

###### PHP8
- For PHP8 go to the docker/php-fpm 
    - Rename the **Dockerfile** to **Dockerfile.php7.txt**
    - Rename the **Dockerfile.php8.txt** to **Dockerfile**
    - Rebuild the project

###### Elastic Stack
In order to use Elastic Stack please uncomment all the Elastic Stack section on `_docker-compose.yml_` and rebuild the project

###### Enjoy


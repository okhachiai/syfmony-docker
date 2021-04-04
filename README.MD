Docker make symfony
-------------------
Symfony with no php, mysql and no nginx in your computer

**Prerequisite**
 - Docker
 - Git And Nothing else
 - For a best exp you need make commande

**Install**
- `git clone https://github.com/okhachiai/symfony-docker.git`
- `make build` or `docker-compose build --no-cache`
- `make start` or `docker-compose up`
- `make symfony` or `docker-compose exec phpfpm symfony new . -q`
- Go to your browser http://localhost you should see a fresh installation of symfony

NB:
--
- If you want the php8 please go to the docker/php-fpm and rename the

**Enjoy**


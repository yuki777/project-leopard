# project-leopard

## Docker based basic PHP/Laravel application template

| Name          | Version   |
| -----         | --------- |
| PHP           | 8.0       |
| Laravel       | 8         |
| Node.js       | 14        |
| npm           | 6         |
| Nginx         | 1.20      |
| PostgreSQL    | 13.4      |
| MySQL         | 8.0       |
| Elasticsearch | 7.13.0    |
| Redis         | 6.2.3     |

## Install

```
# Clone
mkdir -p ~/git
git clone git@github.com:yuki777/project-leopard.git ~/git/project-leopard
cd ~/git/project-leopard

# Up
docker compose up --build --remove-orphans

# Install composer packages
docker exec -u docker -it leopard-php composer install

# DB migrate
docker exec -u docker -it leopard-php php artisan migrate

# Make key
 docker exec -u docker -it lion-php php artisan key:generate

# Front install and watch
docker exec -u docker -it leopard-php npm install
docker exec -u docker -it leopard-php npm run watch
```

## Heroku deployable
- Add `runtime-dyno-metadata`
```
heroku labs:enable runtime-dyno-metadata -a project-leopard-staging
heroku labs:enable runtime-dyno-metadata -a project-leopard-production
```
- Add buildpack
  - `heroku/nodejs`
  - `heroku/php`
- Add-ons
  - Heroku Postgres
  - Heroku Redis
```
heroku redis:info -a project-leopard-production
heroku redis:maxmemory --policy volatile-lru -a project-leopard-production
heroku redis:info -a project-leopard-production
```
  - Bonsai Elasticsearch
  - SMTP(Mailtrap, Sendgrid, etc)
  - Log(Logentries,,, etc)
- [Procfile](Procfile)
- [Release hook](heroku/release-hook.bash)
- [Nginx conf](heroku/nginx.conf)
- [Settings](https://user-images.githubusercontent.com/177159/132989088-f55c261c-456a-49a9-8487-40bf133c14ac.png)

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

<a href="https://heroku.com/deploy?template=https://github.com/yuki777/project-leopard">
<img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>

- Set config
```
heroku config:set APP_KEY=$(docker exec -u docker -it leopard-php php artisan --no-ansi key:generate --show) -a APP_NAME
```

- Add-ons
  - Heroku Postgres
  - Bonsai Elasticsearch
  - Mailtrap
  - Logentries
  - Heroku Redis
```
heroku redis:maxmemory --policy volatile-lru -a APP_NAME
```
- Enable runtime-dyno-metadata
```
heroku labs:enable runtime-dyno-metadata -a APP_NAME
```
- Heroku files
    - [app.json](app.json)
    - [Procfile](Procfile)
    - [Release hook](heroku/release-hook.bash)
    - [Nginx conf](heroku/nginx.conf)
    - [Settings](https://user-images.githubusercontent.com/177159/132989088-f55c261c-456a-49a9-8487-40bf133c14ac.png)

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

## Deployable to Heroku
- [Procfile](Procfile)
- [Release hook](heroku/release-hook.bash)
- [Nginx conf](heroku/nginx.conf)

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

# Front install and watch
docker exec -u docker -it leopard-php npm install
docker exec -u docker -it leopard-php npm run watch
```
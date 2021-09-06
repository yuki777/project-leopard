# project-leopard

## Install
```
# Clone
mkdir -p ~/git
git clone git@github.com:yuki777/project-leopard.git ~/git/project-leopard
cd ~/git/project-leopard
docker compose up --build --remove-orphans

# Install composer packages
docker exec -u docker -it leopard-php composer install

# DB migrate
docker exec -u docker -it leopard-php php artisan migrate

# Front install and watch
docker exec -u docker -it leopard-php npm install
docker exec -u docker -it leopard-php npm run watch
```
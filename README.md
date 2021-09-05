# project-leopard

## Install
```
# clone
mkdir -p ~/git
git clone git@github.com:yuki777/project-leopard.git ~/git/project-leopard
cd ~/git/project-leopard
docker compose up --build --remove-orphans

# install
docker exec -u docker -it leopard-php composer install

# db migrate
docker exec -u docker -it leopard-php php artisan migrate
```
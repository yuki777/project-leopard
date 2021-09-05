#!/bin/bash -eu

if [ "$APP_ENV" = "heroku-testing" ];then
    exit 0
fi

php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

curl -s -X POST \
 --data-urlencode "payload={\"username\": \"Postdeploy Script\", \"text\": \"[$APP_ENV] Postdeploy script completed. $APP_URL :tada: \", \"icon_emoji\": \":rocket:\"}" \
 https://hooks.slack.com/services/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

exit 0

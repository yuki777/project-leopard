#!/bin/bash -eu

EMOJI=""
if [ "$APP_ENV" = "production" ];then
    EMOJI=":tada:"
fi

php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

if [ "$SLACK_NOTIFY_URL" ];then
    curl -s -X POST --data-urlencode "payload={\"username\": \"Postdeploy Script\", \"text\": \"[$APP_ENV] Postdeploy script completed. $APP_URL $EMOJI \", \"icon_emoji\": \":rocket:\"}" $SLACK_NOTIFY_URL
fi

exit 0
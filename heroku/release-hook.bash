#!/bin/bash -eu

php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

env

if [ "$SLACK_WEBHOOK_URL" ];then
    EMOJI=""
    if [ "$APP_ENV" = "production" ];then
        EMOJI=":tada:"
    fi

    # Requirement: `heroku labs:enable runtime-dyno-metadata -a ...`
    MESSAGE="{
        \"blocks\": [
            {
                \"type\": \"section\",
                \"text\": {
                    \"type\": \"mrkdwn\",
                    \"text\": \"*${APP_URL}* has been deployed to *${APP_ENV}* $EMOJI\nDeployed commit: <${GITHUB_URL}/commit/${HEROKU_SLUG_COMMIT}|${HEROKU_SLUG_COMMIT:0:7}>\"
                }
            }
        ]
    }"
    curl -s -X POST -H "Content-type: application/json" --data "$MESSAGE" $SLACK_WEBHOOK_URL
fi

exit 0

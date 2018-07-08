FROM spritsail/alpine:3.8

ENV CRON_HOUR=* \
    CRON_MIN=*/5 \
    CRON_SEC=5

ENV FREEDNS_URL="https://freedns.afraid.org/dynamic/update.php?"

CMD echo -e "${CRON_MIN} ${CRON_HOUR} * * * sleep ${CRON_SEC}; date; echo \"\${TOKENS}\" | while read key; do wget -O- \"\$FREEDNS_URL\${key%%#*}\"; done" \
        | crontab -u cron - && \
    exec crond -d 6 -f

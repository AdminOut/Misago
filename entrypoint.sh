#!/bin/sh
set -e

if [ "x$ENVIRON_NAME" = 'xproduction' ]; then
 echo "Some house keeping: collecting static files and migrating databases" &&
  python manage.py migrate --noinput &&
  python manage.py collectstatic --noinput
fi

exec "$@"

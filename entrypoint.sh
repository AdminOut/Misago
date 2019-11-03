#!/bin/sh
set -e

while ! nc -w 1 -z "${POSTGRES_HOST}" 5432; do
    >&2 echo "Postgres is unavailable - sleeping"
    sleep 1;
done;
>&2 echo "Postgres is up - continuing..."

if [ "x$ENVIRON_NAME" = 'xproduction' ]; then
 echo "Some house keeping: collecting static files and migrating databases" &&
  python manage.py migrate --noinput &&
  python manage.py collectstatic --noinput
fi

exec "$@"

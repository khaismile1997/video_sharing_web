#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /video_sharing_web/tmp/pids/server.pid

# Run migrations.
bundle exec rails db:migrate

# Start the Rails server.
exec "$@"

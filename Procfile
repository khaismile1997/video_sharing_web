web: bundle exec puma -t 5:5 -p ${PORT:-3001} -e ${RACK_ENV:-production}
release: bundle exec rails db:migrate

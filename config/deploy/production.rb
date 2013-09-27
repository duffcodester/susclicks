# production.rb

server '192.241.220.72', :app, :web, :db, :primary => true

set :deploy_to, '/var/www/susclicks'
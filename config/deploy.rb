require 'capistrano/ext/multistage'
require 'rvm/capistrano'

server '192.241.220.72', :app, :web, :db, :primary => true

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :application, 'susclicks'
set :scm, :git
set :user, 'josh'
set :use_sudo, true
set :repository, 'git@github.com:duffcodester/susclicks.git'
set :branch, 'master'
set :scm_passphrase, 'Coppermtn7'
set :ssh_options, { :forward_agent => true }
set :rails_env, 'production'
set :deploy_to, '/home/josh/apps/susclicks'
set :deploy_via, :remote_cache
set :keep_releases, 5

# set :scm_passphrase, 'lxzjwhhwxhrk'

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :stages, ['production']
set :default_stage, 'production'

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end


  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

# role :web, '192.241.220.72'                          # Your HTTP server, Apache/etc
# role :app, '192.241.220.72'                          # This may be the same as your `Web` server
# role :db,  '192.241.220.72', :primary => true        # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
require 'capistrano/ext/multistage'

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :application, 'susclicks'
set :scm, :git
set :user, 'josh'
set :use_sudo, false
set :repository, 'git@github.com:duffcodester/susclicks.git'
set :branch, 'master'
set :scm_passphrase, 'Coppermtn7'
set :ssh_options, { :forward_agent => true }
set :rails_env, 'production'
set :deploy_via, :copy
set :keep_releases, 5

# set :scm_passphrase, 'lxzjwhhwxhrk'

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :stages, ['production']
set :default_stage, 'production'

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
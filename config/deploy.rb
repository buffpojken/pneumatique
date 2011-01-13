set :application, "pneumatique"
set :repository,  "git@github.com:buffpojken/pneumatique.git"
set :port, 34567
set :user, "buffpojken"
set :use_sudo, false
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "94.247.168.97"                                  # Your HTTP server, Apache/etc
role :app, "94.247.168.97"                          # This may be the same as your `Web` server
role :db,  "94.247.168.97", :primary => true # This is where Rails migrations will run

set :deploy_to, "/sites/pneumatique"

ssh_options[:forward_agent] = true
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C thin/production_config.yml -R config.ru start"
  end
 
  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C thin/production_config.yml -R config.ru stop"
  end
 
  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end
 
  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    deploy.update
    deploy.start
  end
end
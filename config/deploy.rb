gem 'capistrano-ext', '>=1.2.1'

$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                         # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-ee@blog'        # Or whatever env you want it to run in.
set :rvm_type, :user

set :use_sudo, false
set :application, "blog"
set :keep_releases, 5
set :scm_verbose, true
set :deploy_via, :remote_cache
set :repository, "git@github.com:lloydpick/blog.git"
set :scm, :git

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :branch, 'master'
set :rails_env, 'production'

set :user, "deploy"
server "balphagore.limi.co.uk", :app, :web, :db, :primary => true

set(:deploy_to) { File.join("", "home", "deploy", "blog.limi.co.uk") }

task :after_update_code do
  run "rm -rf #{release_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"

  run "rm -rf #{release_path}/config/initializers/authentication.rb"
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/initializers/authentication.rb #{release_path}/config/initializers/authentication.rb"

  run "rm -rf #{release_path}/config/initializers/rakismet.rb"
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/initializers/rakismet.rb #{release_path}/config/initializers/rakismet.rb"
end

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

require 'bundler/capistrano'
require 'hoptoad_notifier/capistrano'

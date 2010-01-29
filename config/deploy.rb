gem 'brightbox', '>=2.3.5'
require 'brightbox/recipes'
require 'brightbox/passenger'

set :application, "blog"
set :keep_releases, 5
set :scm_verbose, true
set :deploy_via, :remote_cache
set :repository, "git@github.com:lloydpick/blog.git"
set :scm, :git
set :local_shared_files, %w(config/database.yml config/initializers/authentication.rb)

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :branch, 'master'
set :rails_env, 'production'

set :domain, 'limi.co.uk'
set :domain_aliases, 'www.limi.co.uk,blog.limi.co.uk'

set :user, "limi"
server "andromeda.limi.co.uk", :app, :web, :db, :primary => true

set(:deploy_to) { File.join("", "home", "limi", "domains", "blog.limi.co.uk") }

namespace :db do
  desc 'Dumps the production database to db/production_data.sql on the remote server'
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do
    run "cd #{deploy_to}/#{current_dir} && " +
      "rake RAILS_ENV=#{rails_env} db:database_dump --trace"
  end

  desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
  task :remote_db_download, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/#{rails_env}_data.sql", "db/#{rails_env}_data.sql")
      end
    end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/#{rails_env}_data.sql"
      end
    end
  end

  desc 'Dumps, downloads and then cleans up the production data dump'
  task :remote_db_runner do
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end
end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'

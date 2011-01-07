require 'rake'

namespace :db do
  desc "Dump the current database to a MySQL file"
  task :database_dump do
    load 'config/environment.rb'
    abcs = ActiveRecord::Base.configurations
    case abcs[Rails.env]["adapter"]
    when 'mysql'
      ActiveRecord::Base.establish_connection(abcs[Rails.env])
      File.open("db/#{Rails.env}_data.sql", "w+") do |f|
        if abcs[Rails.env]["password"].blank?
          f << `mysqldump -h #{abcs[Rails.env]["host"]} -u #{abcs[Rails.env]["username"]} #{abcs[Rails.env]["database"]}`
        else
          f << `mysqldump -h #{abcs[Rails.env]["host"]} -u #{abcs[Rails.env]["username"]} -p#{abcs[Rails.env]["password"]} #{abcs[Rails.env]["database"]}`
        end
      end
    when 'sqlite3'
      ActiveRecord::Base.establish_connection(abcs[Rails.env])
      File.open("db/#{Rails.env}_data.sql", "w+") do |f|
        f << `sqlite3 #{abcs[Rails.env]["database"]} .dump`
      end
    else
      raise "Task not supported by '#{abcs[Rails.env]['adapter']}'"
    end
  end
end
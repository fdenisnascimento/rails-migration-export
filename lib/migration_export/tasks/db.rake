# frozen_string_literal: true
require 'fileutils'
desc 'Migration export to sql file with name migration.sql'
namespace :db do
  SQL_FILENAME = 'migrate.sql'

  task migrate_and_export: :environment do
    create_file

    CURRENT_VERSION = ActiveRecord::Base.connection.execute('select max(version) as version from schema_migrations').first['version']

    ActiveRecord::Base.connection.class.class_eval do
      alias_method :old_execute, :execute

      def execute(sql, name = nil)
        if /^(create|alter|drop|insert|delete|update)/i.match sql
          File.open(SQL_FILENAME, 'a') { |f| f.puts "#{sql};\n" }
        end
        old_execute sql, name
      end
    end

    Rake::Task['db:migrate'].invoke

    File.open(SQL_FILENAME, 'a') do |f|
      migrations.map do |t|
        if t.version.to_i > CURRENT_VERSION.to_i
          f.puts "INSERT INTO schema_migrations (version) VALUES ('#{t.version}'); "
        end
      end
    end
  end

  # migration for new database
  task migrate_and_export_all_db: :environment do
    create_file
    Rake::Task['db:structure:dump'].invoke
    FileUtils.mv("#{Rails.root}/db/structure.sql", SQL_FILENAME)
  end

  def migrations
    if version > '5.2.0.beta2'
      ActiveRecord::MigrationContext.new("#{Rails.root}/db/migrate").migrations
    else
      ActiveRecord::Migrator.migrations("#{Rails.root}/db/migrate")
  end

  def version
    Gem.loaded_specs['activerecord'].version
  end

  def create_file
    file = File.open(SQL_FILENAME, 'w')
    file.close
  end

end

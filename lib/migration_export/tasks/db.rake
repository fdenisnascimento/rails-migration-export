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

    # ActiveRecord::Migrator.migrations_paths = "#{Rails.root}/db/migrate"
    File.open(SQL_FILENAME, 'a') do |f|
      ActiveRecord::Migrator.migrations("#{Rails.root}/db/migrate").map do |t|
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

  def create_file
    file = File.open(SQL_FILENAME, 'w')
    file.close
  end

  class ActiveRecord::Migrator
    def self.migrations(paths)
      paths = Array(paths)

      migrations = migration_files(paths).map do |file|
          version, name, scope = parse_migration_filename(file)
          raise IllegalMigrationNameError.new(file) unless version
          version = version.to_i
          name = name.camelize

          MigrationProxy.new(name, version, file, scope)
      end

      migrations.sort_by(&:version)
    end

    def self.migration_files(paths)
        Dir[*paths.flat_map { |path| "#{path}/**/[0-9]*_*.rb" }]
    end
  end
end

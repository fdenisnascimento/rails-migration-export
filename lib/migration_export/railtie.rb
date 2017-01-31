# frozen_string_literal: true
require 'migration_export'
require 'rails'

module MigrationExport

  class Railtie < Rails::Railtie

    railtie_name :migration_export

    rake_tasks do
      load 'migration_export/db.rake'
    end

  end

end

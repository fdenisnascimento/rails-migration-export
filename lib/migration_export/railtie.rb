# frozen_string_literal: true
require 'migration_export'
require 'rails'

module MigrationExport end

class Railtie < Rails::Railtie

  rake_tasks do
    Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
  end

end

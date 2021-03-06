require_relative "../../opt/cleanup_data"
require_relative "../../opt/setup_table"

# Run it like this: rake set_up_table[sf_gov_open_data_dev,eviction_notices,original_eviction_notices]
desc "Set up eviction_notices table"
task :set_up_table, [:database_name, :new_table_name, :copied_table_name] => :environment do |_, args|
  setup = SetupTable.new(args[:database_name], args[:new_table_name], args[:copied_table_name])

  setup.copy_table
  setup.add_primary_key
end

# Run it like this: rake cleanup_data[sf_gov_open_data_dev,eviction_notices]
desc "Clean up data"
task :cleanup_data, [:database_name, :table_name] => :environment do |_, args|
  cleanup_data = CleanupData.new(args[:database_name], args[:table_name])
  cleanup_data.perform
end

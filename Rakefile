require_relative 'common_standards_download'
require_relative 'common_standards_import'
require 'standalone_migrations'

ActiveRecord::SchemaMigration.class_eval do
  def self.table_name
    'standards_schema_migrations'
  end
end

StandaloneMigrations::Tasks.load_tasks

task :default => :import

desc ""
task :import, [:limit] => :fetch do
  puts 'import'
  ENV["ENV"] ||= "development"
  CommonStandardsImport.run('jurisdictions.json', 'standard_sets.json', true)
  CommonStandardsImport.count_children
end

task :count do
  CommonStandardsImport.count_children
end

task :fetch, [:limit] => :clean do |t, args|
  if args[:limit]
    limit = args[:limit].to_i
  end
  api_key = ENV['CSP_API_KEY'] || raise("Please set CSP_API_KEY environment variable")
  CommonStandardsDownload.run(api_key, limit)
  puts 'fetch complete'
end

task :clean do
  ['jurisdictions.json', 'standard_sets.json', 'standards.json'].each do |fname|
    if File.exist?(fname)
      File.delete(fname)
    end
  end
end

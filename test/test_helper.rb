plugin_test_dir = File.dirname(__FILE__)
$:.unshift(plugin_test_dir + '/../lib')

require 'test/unit'
require 'active_record'
require 'active_record/fixtures'

begin
  require 'ruby-debug'
rescue LoadError
  # no debugger available
end

config = ActiveRecord::Base.configurations = YAML::load(IO.read(plugin_test_dir + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(plugin_test_dir + "/debug.log")
ActiveRecord::Base.establish_connection(config[ENV['DB']] || config['postgresql'])

require 'fakey'

class ActiveSupport::TestCase #:nodoc:
  # allow testing in Rails < 2.3
  include ActiveRecord::TestFixtures rescue NameError
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  ActiveRecord::Migration.verbose = false
end
# -*- encoding : utf-8 -*-
require 'fakey/schema_definitions'

module ActiveRecord
  module ConnectionAdapters
    TableDefinition.class_eval { include Fakey::TableDefinition }
    Table.class_eval { include Fakey::Table }
  end
end

if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
  require 'fakey/postgresql_adapter'
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval { include Fakey::PostgreSQLAdapter }
elsif defined?(ActiveRecord::ConnectionAdapters::MysqlAdapter)
  require 'fakey/mysql_adapter'
  ActiveRecord::ConnectionAdapters::MysqlAdapter.class_eval { include Fakey::MysqlAdapter }
else
  raise "Only PostgreSQL and MySQL are currently supported by the fakey plugin."
end

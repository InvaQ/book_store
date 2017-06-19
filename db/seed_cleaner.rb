class SeedCleaner
  def self.call
    tables = ApplicationRecord.subclasses.map { |klass| klass.table_name }

    tables.each do |table|
      ActiveRecord::Base.connection.execute("Truncate table #{table}")
    end
  end
end

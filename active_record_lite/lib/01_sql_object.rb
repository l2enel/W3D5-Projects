require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    cols = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    @columns = cols
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do
        self.attributes[name]
      end

      define_method("#{name}=") do |val|
        self.attributes[name] = value
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name
  end

  def self.all
    # ...
    table = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    table
  end

  def self.parse_all(results)
    # ...
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    # ...
    match = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL

    match
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
    @attributes
  end

  def attribute_values
    # ...
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

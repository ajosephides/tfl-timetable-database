# frozen_string_literal: true

require 'sqlite3'
require 'sequel'

class Database
  attr_accessor :db

  def initialize(path)
    @path = path
    sequel_tube = Sequel.sqlite(path)

    sequel_tube.create_table :stations do
      primary_key String :id
      String :name
      Float :lat
      Float :long
      unique %i[id name lat long]
    end

    sequel_tube.create_table :station_lines do
      String :station_id
      String :line_id
      unique %i[station_id line_id]
    end

    @db = Sequel.connect(adapter: 'sqlite', database: path)
    # @sequel_tube
  end

  def createLinesTable
    @db.create_table :lines do
      primary_key String :id
      String :name
      unique %i[id name]
    end
  end
end

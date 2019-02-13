class Database
  attr_accessor :db

  require 'sqlite3'
  require 'sequel'

  def initialize(path)

    sequel_tube = Sequel.sqlite(path)

    sequel_tube.create_table :lines do
      primary_key String :id
      String :name
      unique [:id, :name]
    end

    sequel_tube.create_table :stations do
      primary_key String :id
      String :name
      Float :lat
      Float :long
      unique [:id, :name, :lat, :long]
    end

    sequel_tube.create_table :station_lines do
      String :station_id
      String :line_id
      unique [:station_id, :line_id]
    end

    @db = Sequel.connect(adapter:'sqlite', database: path)
   # @sequel_tube
  end

end

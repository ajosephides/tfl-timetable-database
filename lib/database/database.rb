# frozen_string_literal: true

require 'sqlite3'
require 'sequel'
require 'tube/line'
require 'tube/station'
require 'tube/lines'
require 'tube/stations'
require 'tube/timetable'
require 'tube/timetables'


class Database
  attr_accessor :db

  def initialize(path)
    sequel_tube = Sequel.sqlite(path)
    @db = Sequel.connect(adapter: 'sqlite', database: path)
  end

  def createLines
    createLinesTable
    lines = Lines.new
    lines.populateJson
    lines.store(self)
  end

  def createStations
    createStationTable
    createStationLineTable
    lines = Lines.new
    lines.populateDb(self.getAllLines)
    stations = Stations.new
    stations.populateJson(lines)
    stations.store(self)
  end
  
  def createLinesTable
    @db.create_table :lines do
      primary_key String :id
      String :name
      unique %i[id name]
    end
  end

  def createStationTable
    @db.create_table :stations do
      primary_key String :id
      String :name
      Float :lat
      Float :long
      unique %i[id name lat long]
    end
  end

  def createStationLineTable
    @db.create_table :station_lines do
      String :station_id
      String :line_id
      unique %i[station_id line_id]
    end
  end

  def getAllLines
    line_ids = @db[:lines].map([:id, :name])
  end

  def getStationIdAndLines
    #stationLines = @db[:station_lines].all
    #for testing use below to give a small subset
    stationLines = @db[:station_lines].where(station_id:'940GZZLUGHK').all
    timetables = Timetables.new
    timetables.populateJson(timetables.collectJson(stationLines))
    puts timetables.all_timetables.inspect
  end

end

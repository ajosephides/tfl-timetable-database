require 'tube/line'
require 'tube/station'
require 'tube/lines'

class Stations
  attr_accessor :all_stations

  def initialize
    @all_stations = []
  end

  def store(db)
    self.all_stations.each { |station| station.store(db) }
  end

  def addStation(station)
    self.all_stations << station
  end
  
end
require 'tube/line'
require 'tube/station'
require 'tube/lines'
require 'api/tfl_api'


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
  
  def populateJson(lines)
    lines.all_lines.each { |line| TflApi.new.tubeStops(line).each{
      |station| self.addStation(Station.new(
        station['id'],
        station['commonName'],
        station['lineModeGroups'].select { |j| j['modeName'] == 'tube' }[0]['lineIdentifier'],
        station['lat'],
        station['lon']
      )
    )
    } 
  }
  end
end
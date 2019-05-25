require 'tube/line'
require 'tube/station'
require 'tube/lines'
require 'api/tfl_api'


class Timetables
  attr_accessor :all_timetables

  def initialize
    @all_timetables = []
  end

  def addTimetable(timetable)
    self.all_timetables << timetable
  end

  def store(db)
    self.all_timetables.each { |timetable| timetable.store(db) }
  end

  def collectJson(stationLines)
    rawJson = []
    stationLines.each { |stationLine| 
      rawJson << TflApi.new.timetable(stationLine)
    }
    #jsonLog(rawJson)
    return rawJson
  end

  def populateJson(rawJson)
    rawJson.each { |station| if station['stops'].size > 0 && station.key?('httpStatusCode') == false && station.key?('statusErrorMessage') == false
      station["timetable"]["routes"][0]["stationIntervals"][0]["intervals"].each{ |timetable| self.addTimetable(Timetable.new(
        station["timetable"]["departureStopId"],
        timetable["stopId"],
        station["lineId"],
        station["direction"],
        timetable["timeToArrival"]
        )
      )
    }
  end
  }
  end

  def jsonLog(rawJson)
    file = File.open("./logs/rawJson.log", "w")
    rawJson.each do |station|
      file.puts station.inspect
    end
    file.close
  end

end

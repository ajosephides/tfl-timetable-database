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

  def collectJson(stationLines)
    rawJson = []
    stationLines.each { |stationLine| 
      rawJson << TflApi.new.timetable(stationLine)
    }
    return rawJson
  end

  def populateJson(rawJson)
    rawJson.each { |station| station["timetable"]["routes"][0]["stationIntervals"][0]["intervals"].
      each{ |timetable| self.addTimetable(Timetable.new(
        station["timetable"]["departureStopId"],
        timetable["stopId"],
        station["lineId"],
        station["direction"],
        timetable["timeToArrival"]
        )
      )
    }
  }
  end

end

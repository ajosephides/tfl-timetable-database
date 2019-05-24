require 'tube/line'
require 'tube/station'
require 'tube/lines'
require 'api/tfl_api'


class Timetables
  attr_accessor :all_timetables

  def initialize
    @all_timetables = []
  end

  def addLine(timetable)
    self.all_timetables << timetable
  end

  def populateJson(stationLines)
    stationLines.each { |stationLine| 
    puts TflApi.new.timetable(stationLine)
  }
  end

end
require 'api/tfl_api'


class Timetable
  attr_accessor :fromStationId, :toStationId, :lineId, :direction, :interval

  def initialize(fromStationId, toStationId, lineId, direction, interval)
    @fromStationId = String(fromStationId) 
    @toStationId = String(toStationId)
    @lineId = String(lineId)
    @direction = String(direction)
    @interval = String(interval)
  end

end
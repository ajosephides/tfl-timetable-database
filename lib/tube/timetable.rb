require 'api/tfl_api'


class Timetable
  attr_accessor :fromStationId, :toStationId, :lineId, :direction, :interval

  def initialize(fromStationId, toStationId, lineId, direction, interval)
    @fromStationId = String(fromStationId) 
    @toStationId = String(toStationId)
    @lineId = String(lineId)
    @direction = String(direction)
    @interval = Float(interval)
  end

  def store(db)
    db.db[:timetables].insert_conflict.insert(from_station: fromStationId, to_station: @toStationId, line_id: @lineId, direction: @direction, interval_mins: @interval)
  end

end
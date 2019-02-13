require 'sqlite3'
require 'sequel'

class Station

  attr_accessor :id, :name, :lines, :lat, :long

  def initialize(id, name, lines, lat, long)
    @id = String(id)
    @name = String(name)
    @lines = [lines]
    @lat = Float(lat)
    @long = Float(long)
  end

def store(db)
  store_station(db)
  store_lines(db)
end

  def store_station(db)
    db.db[:stations].insert_conflict.insert(id:@id, name:@name, lat:@lat, long:@long)
  end

  def store_lines(db)
    lines.each{|i| i.each{|j| db.db[:station_lines].insert_conflict.insert(station_id:@id, line_id:j.to_s)}}
  end

end

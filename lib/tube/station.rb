class Station
  attr_accessor :id, :name, :lines, :lat, :long

  require 'sqlite3'
  require 'sequel'

  def initialize(id, name, lines, lat, long)
    @id = id
    @name = name
    @lines = [lines]
    @lat = lat
    @long = long
  end

  def store(db)
    db.db[:stations].insert_conflict.insert(id:@id.to_s, name:@name.to_s, lat:@lat.to_f, long:@long.to_f)
  end

  def store_lines(db)
    lines.each{|i| i.each{|j| db.db[:station_lines].insert_conflict.insert(station_id:@id.to_s, line_id:j.to_s)}}
  end

end

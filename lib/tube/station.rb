class Station
  attr_accessor :id, :name, :lines, :lat, :long


  def initialize(id, name, lines, lat, long)

    @id = id
    @name = name
    @lines = [lines]
    @lat = lat
    @long = long

  end

end

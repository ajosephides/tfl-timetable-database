class TubeStation
  attr_accessor :stopPointId, :stopPointName, :stopPointLines, :stopPointLat, :stopPointLong


  def initialize(stopPointId, stopPointName, stopPointLines, stopPointLat, stopPointLong)

    @stopPointId = stopPointId
    @stopPointName = stopPointName
    @stopPointLines = [stopPointLines]
    @stopPointLat = stopPointLat
    @stopPointLong = stopPointLong

  end

end

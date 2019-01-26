class TflJsonParse
  require 'json'
  require './lib/tube/line.rb'
  require './lib/tube/station.rb'


  def createTubeLine(jsonResponse)
    tubeLineArray = jsonResponse.map{|i| Line.new(i['id'], i['name'])}
    return tubeLineArray
  end

def createTubeStop(jsonResponse)
  tubeStopArray = jsonResponse.map{|i| Station.new(
    i['id'],
    i['commonName'],
    i['lineModeGroups'].select{|j| j['modeName'] == "tube"}[0]['lineIdentifier'],
    i['lat'],
    i['lon'])}
  return tubeStopArray
end

end

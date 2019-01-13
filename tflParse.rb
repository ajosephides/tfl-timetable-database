class TflJsonParse
  require 'json'
  require './tubeline.rb'
  require './tubestop.rb'



  def createTubeLine(jsonResponse)
    tubeLineArray = jsonResponse.map{|i| TubeLine.new(i['id'], i['name'])}
    return tubeLineArray
  end

def createTubeStop(jsonResponse)
  tubeStopArray = jsonResponse.map{|i| TubeStation.new(
    i['id'],
    i['commonName'],
    i['lineModeGroups'].select{|j| j['modeName'] == "tube"}[0]['lineIdentifier'],
    i['lat'],
    i['lon'])}
    #puts tubeStopArray[5].stopPointName
#jsonResponse.map{|i| puts i['id'], i['commonName'], i['lineModeGroups'].select{|j| j['modeName'] == "tube"}[0]['lineIdentifier'],i['lat'], i['lon']}
  return tubeStopArray
end

end

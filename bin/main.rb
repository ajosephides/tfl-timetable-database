

  require 'database/database'
  require 'tflParse'
  require 'api/tfl_api'

  tubeDb = Database.new
  tubeDb.createDb
  tubeDb.createTubeLineTable
  tubeDb.createTubeStopTable
  tubeDb.createTubeStopTubeLineTable

  tubeLineApi = TflApi.new
  tubeLineParse = TflJsonParse.new
  parseReturn = tubeLineParse.createTubeLine(tubeLineApi.tubeLines)
  parseReturn.each{|i| tubeDb.addTubeLine(i)}

  tubeStopApi = TflApi.new
  tubeStopParse = TflJsonParse.new
  tubeStops = parseReturn.map{|i| tubeStopParse.createTubeStop(tubeStopApi.tubeStops(i))}
  tubeStops.each{|i| i.each{|j| tubeDb.addTubeStop(j)}}
  tubeStops.each{|i| i.each{|j| tubeDb.addTubeStopTubeLine(j)}}

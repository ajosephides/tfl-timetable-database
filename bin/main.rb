require 'database/database'
require 'tflParse'
require 'api/tfl_api'

tubeDb = Database.new('./lib/database/london_tube.db')

tubeLineApi = TflApi.new
tubeLineParse = TflJsonParse.new
parseReturn = tubeLineParse.createTubeLine(tubeLineApi.tubeLines)
parseReturn.each{|i| i.store(tubeDb)}

tubeStopApi = TflApi.new
tubeStopParse = TflJsonParse.new
tubeStops = parseReturn.map{|i| tubeStopParse.createTubeStop(tubeStopApi.tubeStops(i))}

tubeStops.each{|i| i.each{|j| j.store_station(tubeDb)}}
tubeStops.each{|i| i.each{|j| puts j}}
tubeStops.each{|i| i.each{|j| j.store_lines(tubeDb)}}

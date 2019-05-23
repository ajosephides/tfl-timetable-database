# frozen_string_literal: true

require 'database/database'
require 'tflParse'
require 'api/tfl_api'

tubeDb = Database.new('./lib/database/london_tube.db')
tubeDb.createLinesTable

tubeLineApi = TflApi.new
tubeLineParse = TflJsonParse.new
parseReturn = tubeLineParse.createTubeLine(tubeLineApi.tubeLines)
parseReturn.each { |i| i.store(tubeDb) }

tubeStopApi = TflApi.new
tubeStopParse = TflJsonParse.new
tubeStops = parseReturn.map { |i| tubeStopParse.createTubeStop(tubeStopApi.tubeStops(i)) }

tubeStops.each { |i| i.each { |j| j.store(tubeDb) } }

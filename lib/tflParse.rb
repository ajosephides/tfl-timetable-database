# frozen_string_literal: true

require 'json'
require 'tube/line'
require 'tube/station'

class TflJsonParse
  def createTubeLine(jsonResponse)
    tubeLineArray = jsonResponse.map { |i| Line.new(i['id'], i['name']) }
    tubeLineArray
  end

  def createTubeStop(jsonResponse)
    tubeStopArray = jsonResponse.map do |i|
      Station.new(
        i['id'],
        i['commonName'],
        i['lineModeGroups'].select { |j| j['modeName'] == 'tube' }[0]['lineIdentifier'],
        i['lat'],
        i['lon']
      )
    end
    tubeStopArray
  end
end

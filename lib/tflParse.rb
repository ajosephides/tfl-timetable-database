# frozen_string_literal: true

require 'json'
require 'tube/line'
require 'tube/station'
require 'tube/lines'

class TflJsonParse

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

  def tubeLines(json, tubeLines)
    json.select { |line| tubeLines.addLine( Line.new(line['id'], line['name']))} 
  end
end

# frozen_string_literal: true
require 'net/http'
require 'json'
require 'api/secrets'
include Secrets

class TflApi

  def initialize
    super
  end

  def tubeLines
    appId = @APP_ID
    apiKey = @API_KEY
    url = "https://api.tfl.gov.uk/Line/Mode/tube?app_id=#{appId}&app_key=#{apiKey}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def tubeStops(tubeLine)
    appId = @APP_ID
    apiKey = @API_KEY
    url = "https://api.tfl.gov.uk/Line/#{tubeLine.id}/StopPoints?app_id=#{appId}&app_key=#{apiKey}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def timetable(stationLines)
    appId = @APP_ID
    apiKey = @API_KEY
    url = "https://api.tfl.gov.uk/Line/#{stationLines[:line_id]}/Timetable/#{stationLines[:station_id]}?direction=outbound&app_id=#{appId}&app_key=#{apiKey}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)  
  end

end

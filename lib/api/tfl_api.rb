class TflApi

  require 'net/http'
  require 'json'
  require 'api/secrets'

  include Secrets


def initialize
  super
end

  def tubeLines
    appId = @APP_ID
    apiKey = @API_KEY
    url = "https://api.tfl.gov.uk/Line/Mode/tube?app_id=#{appId}&app_key=#{apiKey}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return JSON.parse(response)
  end

def tubeStops(tubeLine)
  appId = @APP_ID
  apiKey = @API_KEY
  url = "https://api.tfl.gov.uk/Line/#{tubeLine.id}/StopPoints?app_id=#{appId}&app_key=#{apiKey}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  return JSON.parse(response)
end


end

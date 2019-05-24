# frozen_string_literal: true

require 'database/database'

tubeDb = Database.new('./lib/database/london_tube.db')
tubeDb.createLines
tubeDb.createStations

tubeDb.getStationIdAndLines
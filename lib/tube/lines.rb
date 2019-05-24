require 'tube/line'
require 'tube/station'
require 'tube/lines'
require 'api/tfl_api'


class Lines
  attr_accessor :all_lines

  def initialize
    @all_lines = []
  end

  def store(db)
    self.all_lines.each { |line| line.store(db) }
  end

  def addLine(line)
    self.all_lines << line
  end

  def populateJson
    rawJson = TflApi.new.tubeLines
    rawJson.select { |line| self.addLine( Line.new(line['id'], line['name']))} 
  end

  def populateDb(lines)
    lines.select { |line| self.addLine( Line.new(line[0], line[1]))} 
  end

end
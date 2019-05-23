require 'tube/line'
require 'tube/station'
require 'tube/lines'

class Lines
  attr_accessor :all_lines

  def initialize
    @all_lines = []
  end

  def store(db)
    puts @all_lines.inspect
    self.all_lines.each { |line| line.store(db) }
  end

  def addLine(line)
    self.all_lines << line
  end

  def populate
    rawJson = TflApi.new.tubeLines
    TflJsonParse.new.tubeLines(rawJson, self)  
  end

end
class DbCalls
  require 'sqlite3'


def createDb
  begin
   #create db
   db = SQLite3::Database.new "london_tube.db"
   puts db.get_first_value 'SELECT SQLITE_VERSION()'

  rescue SQLite3::Exception => e
    puts "Exception Occured"
    puts e

  ensure
    db.close if db
  end
end


  def createTubeLineTable
    begin
      db = SQLite3::Database.open "london_tube.db"
      db.execute "CREATE TABLE IF NOT EXISTS TubeLines(TFL_Line_Id TEXT PRIMARY KEY,
      Name TEXT)"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
    end
  end

  def createTubeStopTable
    begin
      db = SQLite3::Database.open "london_tube.db"
      db.execute "CREATE TABLE IF NOT EXISTS TubeStop(TFL_Station_Id TEXT PRIMARY KEY,
      Name TEXT, LAT REAL, LONG REAL)"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
    end
  end

  def createTubeStopTubeLineTable
    begin
      db = SQLite3::Database.open "london_tube.db"
      db.execute "CREATE TABLE IF NOT EXISTS TubeStopTubeLine(TFL_Station_Id TEXT,
      TFL_Line_Id TEXT, PRIMARY KEY (TFL_Station_Id, TFL_Line_Id),
      FOREIGN KEY (TFL_Station_Id) REFERENCES TubeStop(TFL_Station_Id) ON DELETE CASCADE ON UPDATE NO ACTION,
      FOREIGN KEY (TFL_Line_Id) REFERENCES TubeLines(TFL_Line_Id) ON DELETE CASCADE ON UPDATE NO ACTION)"
      puts "Tube stop tube line table created succesfully"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
    end
  end


  def addTubeLine(tubeLine)
    begin
      db = SQLite3::Database.open "london_tube.db"
      db.execute "INSERT OR IGNORE INTO TubeLines VALUES(?,?)",[tubeLine.id,tubeLine.name]
    rescue SQLite3::Exception => e
      puts "Exception occurred while adding the tube line - #{tubeLine.id}"
      puts e
    ensure
      db.close if db
    end
  end


  def addTubeStop(tubeStop)
    begin
      db = SQLite3::Database.open "london_tube.db"
      db.execute "INSERT OR IGNORE INTO TubeStop VALUES(?,?,?,?)",[tubeStop.id,tubeStop.name,tubeStop.lat,tubeStop.long]
    rescue SQLite3::Exception => e
      puts "Exception occurred while adding the tube stop - #{tubeStop.id}"
      puts e
    ensure
      db.close if db
    end
  end


  def addTubeStopTubeLine(tubeStop)
    begin
      db = SQLite3::Database.open "london_tube.db"
    tubeStop.lines.each{|i| i.each{|j| db.execute "INSERT OR IGNORE INTO TubeStopTubeLine VALUES(?,?)",
      [tubeStop.id, j]}}
  rescue SQLite3::Exception => e
      puts "Exception occurred while adding the tube stop - #{tubeStop.name}"
      puts e
    ensure
      db.close if db
    end
  end



  def getTubeLines
    begin
      db = SQLite3::Database.open "london_tube.db"
      result = db.execute "SELECT * FROM TubeLines"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    ensure
      db.close if db
    end
  end

end

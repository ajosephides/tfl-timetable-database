  require 'sqlite3'
  require 'sequel'

  class Line
  attr_accessor :id, :name

  def initialize(id, name)
    @id = String(id)
    @name = String(name)
  end

  def store(db)
    db.db[:lines].insert_conflict.insert(id:@id, name:@name)
  end

end

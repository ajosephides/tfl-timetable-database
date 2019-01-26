class Line
  attr_accessor :id, :name

  require 'sqlite3'
  require 'sequel'

  def initialize(id, name)
    @id = id
    @name = name
  end

  def store(db)
    db.db[:lines].insert_conflict.insert(id:@id.to_s, name:@name.to_s)
  end

end

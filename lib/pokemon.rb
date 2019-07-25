class Pokemon
  attr_accessor :name, :type, :db, :hp
  attr_reader :id
  
  def initialize(id:, name:, type:, db:)
    @id = id 
    @name = name 
    @type = type
    @db = db
  end 
  
  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type) VALUES (?, ?);
    SQL
    
    db.execute(sql, name, type)
  end 
  
  def self.find(id, db)
    sql = <<-SQL
    SELECT * 
    FROM pokemon
    WHERE id = ?
    SQL
    
    pokemon_new = db.execute(sql, id)[0]
    name = pokemon_new[1]
    type = pokemon_new[2]
    
    poke = Pokemon.new(id: id, name: name, type: type, db: db)
    poke
  end 
  
  def alter_hp(new, db)
    sql = "UPDATE pokemon SET hp = ? WHERE id = ?;"
    id = self.id
    db.execute(sql, new, id)
  end 
  
     
end

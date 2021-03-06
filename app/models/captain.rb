class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where("classifications.name = ?", "Catamaran")
  end 

  def self.sailors
    self.includes(boats: :classifications).where("classifications.name = ?", "Sailboat").uniq
  end 

  def self.motors
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motors.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))

  end 
end

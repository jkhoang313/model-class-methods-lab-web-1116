class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(:classifications).where(classifications: {name: "Sailboat"}).distinct
    # self.joins(:classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.talented_seamen
    self.joins(:classifications).where("classifications.name = 'Motorboat' OR classifications.name = 'Sailboat'").group("classifications.name").order("captains.name asc")
  end

  def self.non_sailors
    sailors = self.joins(:classifications).where("classifications.name = 'Sailboat'").uniq
    sailors_insert = sailors.pluck(:name).collect {|name| "'" + name + "'"}.join(" AND captains.name != ")
    self.joins(:classifications).where("captains.name != #{sailors_insert}").uniq
  end
end

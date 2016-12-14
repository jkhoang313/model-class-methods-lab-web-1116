class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self
  end

  def self.longest
    longest_length = self.joins(:boats).order("boats.length desc").pluck("boats.length").first
    self.joins(:boats).where("length = #{longest_length}")
  end
end

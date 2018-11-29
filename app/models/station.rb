class Station < ApplicationRecord
  has_many :measurements
  has_many :stats
  has_many :averages


end

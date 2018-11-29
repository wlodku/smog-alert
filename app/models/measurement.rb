class Measurement < ApplicationRecord
  before_save :add_qi
  belongs_to :station
  belongs_to :installation

  scope :from_station_id, ->(num) { where(station_id: num) }
  scope :not_from_station_id, ->(num) { where.not(station_id: num) }
  scope :airly, -> {where("installation_id IS NOT NULL")}




  def add_qi
    if pm10 <= 20 && pm25 <= 12
      self.qi = 6
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      self.qi = 5
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      self.qi = 4
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      self.qi = 3
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      self.qi = 2
    end
    if pm10 > 200 || pm25 > 120
      self.qi = 1
    end
  end
end

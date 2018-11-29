class Stat < ApplicationRecord
  belongs_to :station

  scope :not_from_station_id, ->(num) { where.not(station_id: num) }
  # scope :airly_jaworzno, -> { joins(:station).where( 'stations.sensor_id IN ?', [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2353, 744, 1022, 740, 756, 742, 661, 1018, 886, 746, 754, 2502]) }

end

class Array
   def to_array_with_null
     self.map do |val|
       val = "NULL" if val.nil? or (val.respond_to? :empty? and val.empty?)
       val
     end
  end
end

class NewsController < ApplicationController
  include ApplicationHelper
  include NewsHelper

  def november
  end

  def december
  end

  def january
    ids_j = Station.where(:sensor_id => [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2353, 744, 1022, 740, 756, 742, 661, 1018, 886, 746, 754, 2502]).ids
    @stats_airly_jaworzno = Stat.where(:station_id => ids_j)
    date_s = Date.new(2018, 1, 1)
    date_e = Date.new(2018, 1, 31)
    @stats_jaworzno_january = @stats_airly_jaworzno.where(day: date_s..date_e)
  end

  def february
    ids_j = Station.where(:sensor_id => [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2353, 744, 1022, 740, 756, 742, 661, 1018, 886, 746, 754, 2502, 2953, 2883, 2735, 2604]).ids
    @stats_airly_jaworzno = Stat.where(:station_id => ids_j)
    date_s = Date.new(2018, 2, 1)
    date_e = Date.new(2018, 2, 28)
    @stats_jaworzno_february = @stats_airly_jaworzno.where(day: date_s..date_e)

  end

  def march
    ids_j = Station.where(:sensor_id => [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2353, 744, 1022, 740, 756, 742, 661, 1018, 886, 746, 754, 2502, 2953, 2883, 2735, 2604]).ids
    @stats_airly_jaworzno = Stat.where(:station_id => ids_j)
    date_s = Date.new(2018, 3, 1)
    date_e = Date.new(2018, 3, 31)
    @stats_jaworzno = @stats_airly_jaworzno.where(day: date_s..date_e)

    @stats_airly_jaworzno = Stat.where(:station_id => ids_j)
    @stats = @stats_airly_jaworzno.where(day: date_s..date_e)
    @pm10 = [];
    @pm25 = [];

    @stats.order(:day).group_by{|stat| stat.day }.each do |day, s|
      @pm10.push(s.map { |x| x["pm10"].to_f }.reduce(:+) / s.size)
      @pm25.push(s.map { |x| x["pm25"].to_f }.reduce(:+) / s.size)
    end

  end

  def pone
  end

  def measurements
  end

  def test

    @elektrownia10, @elektrownia25 = get24AverageByHours(2261)
    @azotania10, @azotania25 = get24AverageByHours(2247)
    @azot10, @azot25 = get24AverageByHours(2275)
    @huta10, @huta25 = get24AverageByHours(2305)
    @gorka10, @gorka25 = get24AverageByHours(2257)
    @bory10, @bory25 = get24AverageByHours(2286)
    @byczyna10, @byczyna25 = get24AverageByHours(2311)
    @jelenk10, @jelenk25 = get24AverageByHours(2290)
    @jelenw10, @jelenw25 = get24AverageByHours(2353)

    @jeziorki10, @jeziorki25 = get24AverageByHours(744)
    @rynek10, @rynek25 = get24AverageByHours(1022)
    @galena10, @galena25 = get24AverageByHours(740)
    @podleze10, @podleze25 = get24AverageByHours(756)
    @podwale10, @podwale25 = get24AverageByHours(742)
    @basen10, @basen25 = get24AverageByHours(661)
    @dlugoszyn10, @dlugoszyn25 = get24AverageByHours(1018)
    @szczakowa10, @szczakowa25 = get24AverageByHours(886)
    @pieczyska10, @pieczyska25 = get24AverageByHours(746)
    @ciezkowice10, @ciezkowice25 = get24AverageByHours(754)
  end

  def test2
  end

end

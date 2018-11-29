require "open-uri"
require "date"
require "active_support/time"

namespace :smog do

  desc "Send alert via email"
  task get_data: :environment do
    #airly
    if Time.now.min/10 % 2 == 0
      apis = []
      apis.push(Setting.api_key1) unless Setting.api_key1.blank?
      apis.push(Setting.api_key2) unless Setting.api_key2.blank?
      apis.push(Setting.api_key3) unless Setting.api_key3.blank?
      apis.push(Setting.api_key4) unless Setting.api_key4.blank?

      sensors_ids = Installation.all.map { |n| n.sensor_id }
      sensors_ids.each do |id|
        responce = RestClient::Request.execute(
          :method => :get,
          :url => "https://airapi.airly.eu/v2/measurements/installation?installationId=#{id}",
          # :url => "https://airapi.airly.eu/v1/sensor/measurements/?sensorId=#{id}",
          :headers => {'apikey' => apis.sample}
        )
        data = JSON.parse(responce)
        next if data["current"].blank?
        Measurement.create(pm1: data["current"]["values"][0]["value"].to_i,
  	    								   pm25: data["current"]["values"][1]["value"].to_i,
  	    								   pm10: data["current"]["values"][2]["value"].to_i,
  	    								   measured_at: Time.now,
  	    								   installation_id: Installation.find_by(sensor_id: id).id
  	    				  				 ) unless data["current"].blank?
      end
    end

    #LookO2
    url = "http://api.looko2.com/?method=GetLOOKO&id=6001944BCDF1&token=1512762342"
    data = JSON.parse(open(url).read)
    time = Time.strptime((data["Epoch"].to_i).to_s,'%s')
    Measurement.create(pm1: data["PM1"].to_i, pm25: data["PM25"].to_i, pm10: data["PM10"].to_i, epoch: data["Epoch"], measured_at: time, station_id: 1)

    #remove oldest
    if Measurement.count > 6000
      ids = Measurement.order('created_at ASC').limit(1000).pluck(:id)
      Measurement.where(id: ids).delete_all
    end

    send_emails if Setting.notif_on == "1"

  end



  def send_emails
  	users_to_warn = User.activated.not_spammed
  	live = []
    Measurement.last(2000).group_by{ |s| s.installation_id }.each do |s, m|
      live.push(m.last) if m.last.created_at > 3.hours.ago
    end

  	users_to_warn.each	do |u|
			over_critical_measurements = live.select { |m| m.qi <= u.critical }
    	followed_by_user = u.subscriptions.map { |s| s.installation_id }
    	measurements = over_critical_measurements.select { |m| followed_by_user.include?(m.installation_id)}
    	if measurements.count > 0
    		u.update_attribute(:email_sent_at, Time.now) if UserMailer.alert(u, measurements).deliver
    	end
  	end
	end

  desc "Send alert via email"
  task test_mail: :environment do
    users_to_warn = User.activated.not_spammed
    puts users_to_warn
    live = []
    Measurement.last(2000).group_by{ |s| s.installation_id }.each do |s, m|
      live.push(m.last) if m.last.created_at > 3.hours.ago
    end

    users_to_warn.each	do |u|
      over_critical_measurements = live.select { |m| m.qi <= u.critical }
      followed_by_user = u.subscriptions.map { |s| s.installation_id }
      measurements = over_critical_measurements.select { |m| followed_by_user.include?(m.installation_id)}
      if measurements.count > 0
        u.update_attribute(:email_sent_at, Time.now) if UserMailer.alert(u, measurements).deliver
      end
    end
  end

  desc "Get data from looko2"
  task get_looko2: :environment do
    url = "http://api.looko2.com/?method=GetLOOKO&id=6001944BCDF1&token=1512762342"
    data = JSON.parse(open(url).read)
    time = Time.strptime((data["Epoch"].to_i).to_s,'%s')
    Measurement.create(pm1: data["PM1"].to_i, pm25: data["PM25"].to_i, pm10: data["PM10"].to_i, epoch: data["Epoch"], measured_at: time, station_id: 1)
  end

  desc "Add Stat from yesterday"
  task calculateLastDay: :environment do
    date = Time.now.in_time_zone("Warsaw") - 1.day
    Station.ids.each do |id|
      records = Measurement.from_station_id(id).where(created_at: date.midnight..date.end_of_day)
      Stat.create(day: date, station_id: id, pm10: records.average(:pm10).round(2), pm25: records.average(:pm25).round(2)) if records.count > 0
    end
  end

  desc "Add Stat from day before yesterday"
  task calculatePreLastDay: :environment do
    date = Time.now.in_time_zone("Warsaw") - 2.day
    Station.ids.each do |id|
      records = Measurement.from_station_id(id).where(created_at: date.midnight..date.end_of_day)
      Stat.create(day: date, station_id: id, pm10: records.average(:pm10).round(2), pm25: records.average(:pm25).round(2)) if records.count > 0
    end
  end


  desc "Remove stat from current day"
  task removeCurrentDay: :environment do
    date = Time.now.in_time_zone("Warsaw")
    trash = Stat.where(day: date)
    trash.delete_all
  end

  desc "Remove stat from yesterday"
  task removeLastDay: :environment do
    date = Time.now.in_time_zone("Warsaw") - 1.day
    trash = Stat.where(day: date)
    trash.delete_all
  end

  desc "Remove stat from day before yesterday"
  task removePreLastDay: :environment do
    date = Time.now.in_time_zone("Warsaw") - 2.day
    trash = Stat.where(day: date)
    trash.delete_all
  end

  desc "Remove measurements from the oldest day"
  task removeOldest: :environment do
    date = Measurement.first.created_at
    trash = Measurement.where(created_at: date.midnight..date.end_of_day)
    trash.delete_all
  end

  desc "Remove all stats"
  task removeAllStats: :environment do
    trash = Stat.all
    trash.delete_all
  end

  desc "Calculate all stats"
  task calculateAllStats: :environment do
    Station.ids.each do |id|
      Measurement.from_station_id(id).group_by{|m| m.created_at.in_time_zone("Warsaw").strftime("%Y-%m-%d") }.each do |d, m|
          avg10 = m.map { |x| x["pm10"].to_f }.reduce(:+) / m.size
          avg25 = m.map { |x| x["pm25"].to_f }.reduce(:+) / m.size
          Stat.create(day: d, station_id: id, pm10: avg10.round(2), pm25: avg25.round(2))
      end
    end
    date = Time.now.in_time_zone("Warsaw")
    trash = Stat.where(day: date)
    trash.delete_all
  end

  desc "Add measurement from API and caluclate daily average once a day"
  task getdata: :environment do

    #run one a day after midnight
    if Time.now.in_time_zone("Warsaw").hour == 0 && Time.now.in_time_zone("Warsaw").min < 10
      # date = Time.now.in_time_zone("Warsaw") - 1.day
      # Station.ids.each do |id|
      #   records = Measurement.from_station_id(id).where(created_at: date.midnight..date.end_of_day)
      #   Stat.create(day: date, station_id: id, pm10: records.average(:pm10).round(2), pm25: records.average(:pm25).round(2)) if records.count > 0
      # end

      #calculate daily averages from api (only Jawo)
      sensors_ids = [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2953, 2604, 1022, 740, 756, 742, 661, 2883, 886, 2735, 754, 2502]


      #calculate daily averages from api (including Jawo, Kato, Sosno, Mce, DG)
      # sensors_ids = [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2953, 2604, 1022, 740, 756, 742, 661, 2883, 886, 2735, 754, 2502, 2405, 1095, 815, 2351, 738, 696, 690, 560, 689, 2268, 2213, 2142, 2249, 700, 749, 599, 2137, 697, 695, 448, 398, 2595, 2566, 2357]

      sensors_ids.each do |id|
        responce = RestClient::Request.execute(
          :method => :get,
          :url => "https://airapi.airly.eu/v1/sensor/measurements/?sensorId=#{id}",
          :headers => {'apikey' => '7da0b4b072c4431985f39529ebde4cdc'}
          # :headers => {'apikey' => 'd35b7c52eaad4c9cbe60b8b7e6e31167'}
        )
        data = JSON.parse(responce)
        date = Time.now.in_time_zone("Warsaw") - 1.day
        pm10 = []
        pm25 = []
        data["history"].each do |h|
          pm10.push(h["measurements"]["pm10"]) unless h["measurements"]["pm10"].blank?
          pm25.push(h["measurements"]["pm25"]) unless h["measurements"]["pm25"].blank?
        end
        next if pm10.size == 0 || pm25.size == 0
        Stat.create(day: date, station_id: Station.find_by(sensor_id: id).id, pm10: pm10.reduce(:+).to_f / pm10.size, pm25: pm25.reduce(:+).to_f / pm25.size)
      end

      #remove oldest records
      date = Measurement.first.created_at
      trash = Measurement.where(created_at: date.midnight..date.end_of_day)
      trash.delete_all

      #prevent fetching current measurements from API
      next

    end

    if Time.now.min/10 % 2 == 1
      # url = "http://api.looko2.com/?method=GetLOOKO&id=2C3AE834012A&token=1512762342"
      url = "http://api.looko2.com/?method=GetLOOKO&id=6001944BCDF1&token=1512762342"
      data = JSON.parse(open(url).read)
      time = Time.strptime((data["Epoch"].to_i).to_s,'%s')
      Measurement.create(pm1: data["PM1"].to_i, pm25: data["PM25"].to_i, pm10: data["PM10"].to_i, epoch: data["Epoch"], measured_at: time, station_id: 1)

      sensors_ids = [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2953, 2604]

      sensors_ids.each do |id|
        responce = RestClient::Request.execute(
          :method => :get,
          :url => "https://airapi.airly.eu/v1/sensor/measurements/?sensorId=#{id}",
          :headers => {'apikey' => '69ddeef752e442cb9e094d43776b4f1c'}
        )
        dataA = JSON.parse(responce)
        next if dataA["currentMeasurements"].blank?
        Measurement.create(pm1: dataA["currentMeasurements"]["pm1"].to_i, pm25: dataA["currentMeasurements"]["pm25"].to_i, pm10: dataA["currentMeasurements"]["pm10"].to_i, measured_at: Time.now, station_id: Station.find_by(sensor_id: id).id) unless dataA["currentMeasurements"].blank?
        #
        # if Time.now.in_time_zone("Warsaw").day != Measurement.last.created_at.in_time_zone("Warsaw").day || Average.all.count < 18
        #   date = Time.now.in_time_zone("Warsaw") - 1.day
        #   pm10 = []
        #   pm25 = []
        #   dataA["history"].each do |h|
        #     pm10.push(h["measurements"]["pm10"])
        #     pm25.push(h["measurements"]["pm25"])
        #   end
        #   Average.create(day: date, station_id: Station.find_by(sensor_id: id).id, pm10: pm10.reduce(:+).to_f / pm10.size, pm25: pm25.reduce(:+).to_f / pm25.size) if pm10.size > 0
        # end

      end
    else
      sensors_ids = [1022, 740, 756, 2502, 742, 661, 2883, 886, 2735, 754]

      sensors_ids.each do |id|
        responce = RestClient::Request.execute(
          :method => :get,
          :url => "https://airapi.airly.eu/v1/sensor/measurements/?sensorId=#{id}",
          :headers => {'apikey' => 'd35b7c52eaad4c9cbe60b8b7e6e31167'}
        )
        dataA = JSON.parse(responce)
        next if dataA["currentMeasurements"].blank?
        Measurement.create(pm1: dataA["currentMeasurements"]["pm1"].to_i, pm25: dataA["currentMeasurements"]["pm25"].to_i, pm10: dataA["currentMeasurements"]["pm10"].to_i, measured_at: Time.now, station_id: Station.find_by(sensor_id: id).id) unless dataA["currentMeasurements"].blank?

        # if Time.now.in_time_zone("Warsaw").day != Measurement.last.created_at.in_time_zone("Warsaw").day || Average.all.count < 18
        #   date = Time.now.in_time_zone("Warsaw") - 1.day
        #   pm10 = []
        #   pm25 = []
        #   dataA["history"].each do |h|
        #     pm10.push(h["measurements"]["pm10"])
        #     pm25.push(h["measurements"]["pm25"])
        #   end
        #   Average.create(day: date, station_id: Station.find_by(sensor_id: id).id, pm10: pm10.reduce(:+).to_f / pm10.size, pm25: pm25.reduce(:+).to_f / pm25.size) if pm10.size > 0
        # end


      end

    end

  end

  task calculateStatFromApi: :environment do
    sensors_ids = [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2953, 2604, 1022, 740, 756, 750, 742, 661, 2883, 886, 2735, 754]

    sensors_ids.each do |id|
      responce = RestClient::Request.execute(
        :method => :get,
        :url => "https://airapi.airly.eu/v1/sensor/measurements/?sensorId=#{id}",
        :headers => {'apikey' => 'd35b7c52eaad4c9cbe60b8b7e6e31167'}
      )
      data = JSON.parse(responce)
      date = Time.now.in_time_zone("Warsaw") - 1.day
      pm10 = []
      pm25 = []
      data["history"].each do |h|
        pm10.push(h["measurements"]["pm10"]) unless h["measurements"]["pm10"].blank?
        pm25.push(h["measurements"]["pm25"]) unless h["measurements"]["pm25"].blank?
      end
      next if pm10.size == 0 || pm25.size == 0
      Stat.create(day: date, station_id: Station.find_by(sensor_id: id).id, pm10: pm10.reduce(:+).to_f / pm10.size, pm25: pm25.reduce(:+).to_f / pm25.size)
    end
  end

  #useless helpers

  task epochtodate: :environment do
    Measurement.all.each do |m|
      m.measured_at = Time.strptime(m.epoch,'%s')
      m.save
    end
  end

  task asd: :environment do
    puts "First"
    if Time.now.day != Time.now.day - 1.day

      next
    end
  end

  task qwe: :environment do
    responce = RestClient::Request.execute(
     :method => :get,
     :url => "https://airapi.airly.eu/v1/sensor/measurements?sensorId=750",
     # :url => "https://airapi.airly.eu/v1/heatmap/current?southwestLat=50&southwestLong=19.9&northeastLat=50.09&northeastLong=20.02&widthPixels=100",
     :headers => {'apikey' => 'd35b7c52eaad4c9cbe60b8b7e6e31167'}
    )
    data = JSON.parse(responce)
    puts data

    # pm10 = []
    # pm25 = []
    # data["history"].each do |h|
    #   pm10.push(h["measurements"]["pm10"])
    #   pm25.push(h["measurements"]["pm25"])
    # end
    # puts pm10.reduce(:+).to_f / pm10.size
    # puts pm25.reduce(:+).to_f / pm10.size
    # puts data
  end

  task emi: :environment do
    responce = RestClient::Request.execute(
     :method => :get,
     :url => "https://airapi.airly.eu/v1/sensor/measurements?sensorId=742",
     # :url => "https://airapi.airly.eu/v1/heatmap/current?southwestLat=50&southwestLong=19.9&northeastLat=50.09&northeastLong=20.02&widthPixels=100",
     :headers => {'apikey' => '7da0b4b072c4431985f39529ebde4cdc'}
    )
    data = JSON.parse(responce)
    puts data

    # pm10 = []
    # pm25 = []
    # data["history"].each do |h|
    #   pm10.push(h["measurements"]["pm10"])
    #   pm25.push(h["measurements"]["pm25"])
    # end
    # puts pm10.reduce(:+).to_f / pm10.size
    # puts pm25.reduce(:+).to_f / pm10.size
    # puts data
  end

  task fixDN: :environment do
    Station.where(station_id: 750).update(station_id: 2502)

  end

end

require "open-uri"
require 'date'
require 'active_support/time'


class DashboardController < ApplicationController
  include ApplicationHelper
  def index
    # url = "http://api.looko2.com/?method=GetLOOKO&id=2C3AE834012A&token=1512762342"
    url = "http://api.looko2.com/?method=GetLOOKO&id=6001944BCDF1&token=1512762342"
    @jk_values = JSON.parse(open(url).read)
    # @pom =  Measurement.group("DATE_PART('hour', measured_at)").average(:pm10)

    # Kopernika
    @pom10, @pom25 = get24AverageByHours(1)


    # Hash[get24AverageByHours(2247).to_a.reverse].to_hash
    # Hash[a.to_a.reverse].to_hash

  end




  def live
    #live table
    live = []
    Measurement.airly.last(1000).group_by{ |s| s.installation_id }.each do |s, m|
      live.push(m.last) if m.last.created_at > 3.hours.ago
    end
    @live = live.sort_by{|m| -m[:pm10]}
    @updated = live.sort_by{|m| m[:created_at]}.last.created_at.in_time_zone("Warsaw").strftime("%H:%M") unless live.blank?
    @updated ||= '-'

    #daily avg
    @daily_pm10_avg = Measurement.airly.where(measured_at: (Time.now - 24.hours)..Time.now).average(:pm10).round unless Measurement.airly.where(measured_at: (Time.now - 24.hours)..Time.now).blank?
    @daily_pm10_avg ||= 0
    @daily_pm25_avg = Measurement.airly.where(measured_at: (Time.now - 24.hours)..Time.now).average(:pm25).round unless Measurement.airly.where(measured_at: (Time.now - 24.hours)..Time.now).blank?
    @daily_pm25_avg ||= 0

    #main chart
    @area10, @area25 = get24AverageByHoursForArea

    #multi chart
    @multichart_live = []

    Installation.all.each do |i|
      @multichart_live.push(i.name)
      @multichart_live.push(get24AverageByHoursForInstallation(i.id).values.map { |v| v.round })
    end
    
    unless @multichart_live.empty?
      @multichart_live.unshift(get24AverageByHoursForInstallation(Installation.first.id).keys.map{|v| v})
      @multichart_live.unshift("live")
    end


  end

  def how
  end

  def contact
  end

  def rest
  end

  def deadline
  end

  def widgety
  end

  def jawpl
  end

end

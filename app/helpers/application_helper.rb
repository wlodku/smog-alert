module ApplicationHelper

  def get24AverageByHoursForInstallation(installation_id)    
    pm10 = {}
    pm25 = {}
    Measurement.where(installation_id: installation_id).where(measured_at: (Time.now - 23.hours)..Time.now).order(created_at: :asc).group_by{ |s| s.measured_at.in_time_zone("Warsaw").hour }.each do |h, m|
      sum10 = 0
      sum25 = 0
      m.each do |p|
        sum10 += p.pm10
        sum25 += p.pm25
      end
      pm10[h] = sum10/m.length
      pm25[h] = sum25/m.length
    end
    return pm10
  end

  def get24AverageByHours(sensor_id)
    station = Station.find_by(sensor_id: sensor_id)
    pm10 = {}
    pm25 = {}
    Measurement.from_station_id(station.id).where(measured_at: (Time.now - 23.hours)..Time.now).order(created_at: :asc).group_by{ |s| s.measured_at.in_time_zone("Warsaw").hour }.each do |h, m|
      sum10 = 0
      sum25 = 0
      m.each do |p|
        sum10 += p.pm10
        sum25 += p.pm25
      end
      # pm10[h] = sum10/m.length
      pm10[h] = sum10/m.length
      pm25[h] = sum25/m.length
    end
    return pm10, pm25
  end

  def get24AverageByHoursForArea
    pm10 = {}
    pm25 = {}
    Measurement.where(measured_at: (Time.now - 23.hours)..Time.now).order(created_at: :asc).group_by{ |s| s.measured_at.in_time_zone("Warsaw").hour }.each do |h, m|
      sum10 = 0
      sum25 = 0
      m.each do |p|
        sum10 += p.pm10
        sum25 += p.pm25
      end
      # pm10[h] = sum10/m.length
      pm10[h] = sum10/m.length
      pm25[h] = sum25/m.length
    end
    return pm10, pm25
  end

  def get24AverageByHoursForWidget
    pm10 = {}
    pm25 = {}
    Measurement.where(measured_at: (Time.now - 8.hours)..Time.now).order(created_at: :asc).group_by{ |s| s.measured_at.in_time_zone("Warsaw").hour }.each do |h, m|
      sum10 = 0
      sum25 = 0
      m.each do |p|
        sum10 += p.pm10
        sum25 += p.pm25
      end
      # pm10[h] = sum10/m.length
      pm10[h] = sum10/m.length
      pm25[h] = sum25/m.length
    end
    return pm10, pm25
  end

  def getColor pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "<td class='w3-blue'>Bardzo dobrze</td>"
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "<td class='w3-green'>Dobrze</td>"
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "<td class='w3-yellow'>Umiarkowanie</td>"
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "<td class='w3-orange'>Niekorzystnie</td>"
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "<td class='w3-red'>Źle</td>"
    end
    if pm10 > 200 || pm25 > 120
      result = "<td class='w3-purple'>Bardzo źle</td>"
    end
    result.html_safe
  end

  def getColor2 pm10
    result = ""
    if pm10 <= 20
      result = "<td class='w3-blue w3-center' colspan='3'>Bardzo dobrze</td>"
    end
    if pm10 > 20 && pm10 <= 50
      result = "<td class='w3-green w3-center' colspan='3'>Dobrze</td>"
    end
    if pm10 > 50 && pm10 <= 100
      result = "<td class='w3-yellow w3-center' colspan='3'>Umiarkowanie</td>"
    end
    if pm10 > 100 && pm10 <= 140
      result = "<td class='w3-orange w3-center' colspan='3'>Niekorzystnie</td>"
    end
    if pm10 > 140 && pm10 <= 200
      result = "<td class='w3-red w3-center' colspan='3'>Źle</td>"
    end
    if pm10 > 200
      result = "<td class='w3-purple w3-center' colspan='3'>Bardzo źle</td>"
    end
    result.html_safe
  end


  def getWidgetColor pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "<div class='card-panel valign-wrapper blue' style='height: 60px; margin: 0; color: white;'>"
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "<div class='card-panel valign-wrapper green' style='height: 60px; margin: 0; color: white;'>"
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "<div class='card-panel valign-wrapper yellow' style='height: 60px; margin: 0;'>"
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "<div class='card-panel valign-wrapper orange' style='height: 60px; margin: 0;'>"
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "<div class='card-panel valign-wrapper red' style='height: 60px; margin: 0; color: white;'>"
    end
    if pm10 > 200 || pm25 > 120
      result = "<div class='card-panel valign-wrapper purple' style='height: 60px; margin: 0; color: white;'>"
    end
    result.html_safe
  end



  def getWidgetColorSmall pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "<div class='card-panel blue valign-wrapper' style='height: 40px; padding: 0px; color: white;'>"
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "<div class='card-panel green valign-wrapper' style='height: 40px; padding: 0px; color: white;'>"
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "<div class='card-panel yellow valign-wrapper' style='height: 40px; padding: 0px;'>"
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "<div class='card-panel orange valign-wrapper' style='height: 40px; padding: 0px;'>"
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "<div class='card-panel red valign-wrapper' style='height: 40px; padding: 0px; color: white;'>"
    end
    if pm10 > 200 || pm25 > 120
      result = "<div class='card-panel purple valign-wrapper' style='height: 40px; padding: 0px; color: white;'>"
    end
    result.html_safe
  end

  def getMark pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "Bardzo dobre"
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "Dobre"
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "Umiarkowane"
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "Niekorzystnie"
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "Złe"
    end
    if pm10 > 200 || pm25 > 120
      result = "Bardzo złe"
    end
    result.html_safe
  end

  def getInterpretation pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "Jakość powietrza jest bardzo dobra, zanieczyszczenie powietrza nie stanowi zagrożenia dla zdrowia, warunki bardzo sprzyjające do wszelkich aktywności na wolnym powietrzu, bez ograniczeń."
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "Jakość powietrza jest zadowalająca, zanieczyszczenie powietrza powoduje brak lub niskie ryzyko zagrożenia dla zdrowia. Można przebywać na wolnym powietrzu i wykonywać dowolną aktywność, bez ograniczeń."
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "Jakość powietrza jest akceptowalna. Zanieczyszczenie powietrza może stanowić zagrożenie dla zdrowia w szczególnych przypadkach (dla osób chorych, osób starszych, kobiet w ciąży oraz małych dzieci). Warunki umiarkowane do aktywności na wolnym powietrzu."
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "Jakość powietrza jest dostateczna, zanieczyszczenie powietrza stanowi zagrożenie dla zdrowia (szczególnie dla osób chorych, starszych, kobiet w ciąży oraz małych dzieci) oraz może mieć negatywne skutki zdrowotne. Należy rozważyć ograniczenie (skrócenie lub rozłożenie w czasie) aktywności na wolnym powietrzu, szczególnie jeśli ta aktywność wymaga długotrwałego lub wzmożonego wysiłku fizycznego."
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "Jakość powietrza jest zła, osoby chore, starsze, kobiety w ciąży oraz małe dzieci powinny unikać przebywania na wolnym powietrzu. Pozostała populacja powinna ograniczyć do minimum wszelką aktywność fizyczną na wolnym powietrzu - szczególnie wymagającą długotrwałego lub wzmożonego wysiłku fizycznego."
    end
    if pm10 > 200 || pm25 > 120
      result = "Jakość powietrza jest bardzo zła i ma negatywny wpływ na zdrowie. Osoby chore, starsze, kobiety w ciąży oraz małe dzieci powinny bezwzględnie unikać przebywania na wolnym powietrzu. Pozostała populacja powinna ograniczyć przebywanie na wolnym powietrzu do niezbędnego minimum. Wszelkie aktywności fizyczne na zewnątrz są odradzane. Długotrwała ekspozycja na działanie substancji znajdujących się w powietrzu zwiększa ryzyko wystąpienia zmian m.in. w układzie oddechowym, naczyniowo-sercowym oraz odpornościowym."
    end
    result.html_safe
  end

  def getQI pm10, pm25
    result = 0
    if pm10 <= 20 && pm25 <= 12
      result = 6
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = 5
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = 4
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = 3
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = 2
    end
    if pm10 > 200 || pm25 > 120
      result = 1
    end
    result
  end

end

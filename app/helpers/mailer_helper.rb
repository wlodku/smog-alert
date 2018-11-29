module MailerHelper
  def getMailMark pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "BARDZO DOBRA"
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "DOBRA"
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "UMIARKOWANA"
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "NIEKORZYSTNA"
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "ZŁA"
    end
    if pm10 > 200 || pm25 > 120
      result = "BARDZO ZŁA"
    end
    result
  end

  def getMailColor pm10, pm25
    result = ""
    if pm10 <= 20 && pm25 <= 12
      result = "w6"
    end
    if (pm10 > 20 && pm10 <= 50) || (pm25 > 12 && pm25 <= 36)
      result = "w5"
    end
    if (pm10 > 50 && pm10 <= 100) || (pm25 > 36 && pm25 <= 60)
      result = "w4"
    end
    if (pm10 > 100 && pm10 <= 140) || (pm25 > 60 && pm25 <= 84)
      result = "w3"
    end
    if (pm10 > 140 && pm10 <= 200) || (pm25 > 84 && pm25 <= 120)
      result = "w2"
    end
    if pm10 > 200 || pm25 > 120
      result = "w1"
    end
    result
  end

end

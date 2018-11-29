class Notif
  @@body = 'Uwaga uwaga'

  def initialize(active, stop_at_night)
    @active = active
    @stop_at_night = stop_at_night
  end

  attr_accessor :active
  attr_accessor :stop_at_night

  def body
    @@body
  end

end

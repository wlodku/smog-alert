class WidgetsController < ApplicationController
  include ApplicationHelper
  before_filter :allow_iframe_requests

  def show
    live = []
    Measurement.airly.last(1000).group_by{ |s| s.installation_id }.each do |s, m|
      live.push(m.last) if m.last.created_at > 3.hours.ago
    end
     @live2 = live.sort_by{|m| -m[:pm10]}
     @live3 = live.sort_by{|m| m[:created_at]}

     @avg10 = live.map { |x| x["pm10"].to_f }.reduce(:+) / live.size
     @avg25 = live.map { |x| x["pm25"].to_f }.reduce(:+) / live.size

     @jaw10, @jaw25 = get24AverageByHoursForWidget

    respond_to do |format|
      format.html { render params[:template], layout: 'widgets' }
      format.js   { render js: js_constructor }
    end
  end

  private
  def js_constructor
    content = render_to_string(params[:template], layout: false)
    "document.write(#{content.to_json})"
  end



  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end
end

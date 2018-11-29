class StatsController < ApplicationController
  before_action :set_stat, only: [:show, :edit, :update, :destroy]

  # GET /stats
  # GET /stats.json
  def index
    @stats = Stat.all.order(:day)
    ids_j = Station.where(:sensor_id => [2261, 2247, 2275, 2305, 2257, 2286, 2311, 2290, 2353, 744, 1022, 740, 756, 742, 661, 1018, 886, 746, 754, 2502, 2953, 2883, 2735, 2604]).ids
    ids_s = Station.where(:sensor_id => [2405, 1095, 815, 2351, 738, 696, 690, 560, 689, 695, 697]).ids
    ids_m = Station.where(:sensor_id => [2268, 2213, 2595, 2566]).ids
    ids_k = Station.where(:sensor_id => [2142, 2249, 700, 749, 599, 2137]).ids
    ids_dg = Station.where(:sensor_id => [448, 398]).ids
    ids_ch = Station.where(:sensor_id => [2357]).ids
    @stats_airly_jaworzno = Stat.where(:station_id => ids_j)
    @stats_airly_sosnowiec = Stat.where(:station_id => ids_s)
    @stats_airly_myslowice = Stat.where(:station_id => ids_m)
    @stats_airly_katowice = Stat.where(:station_id => ids_k)
    @stats_airly_dg = Stat.where(:station_id => ids_dg)
    @stats_airly_ch = Stat.where(:station_id => ids_ch)
    @staty = Measurement.group(:date)

    date_s = Date.new(2018, 1, 1)
    date_e = Date.new(2018, 1, 31)
    @stats_jaworzno_january = @stats_airly_jaworzno.where(day: date_s..date_e)
    @stats_jaworzno_february = @stats_airly_jaworzno.where(day: Date.new(2018, 2, 1)..Date.new(2018, 2, 28))
    @stats_jaworzno_march = @stats_airly_jaworzno.where(day: Date.new(2018, 3, 1)..Date.new(2018, 3, 31))

    date_wios_s = Date.new(2018, 2, 23)
    date_wios_e = Date.new(2018, 3, 9)
    @stats_wios_rynek = Stat.where(station_id: 12)
    @stats_wios_rynek = @stats_wios_rynek.where(day: date_wios_s..date_wios_e)
    @stats_wios_plac = Stat.where(station_id: 13)
    @stats_wios_plac = @stats_wios_plac.where(day: date_wios_s..date_wios_e)
  end

  # GET /stats/1
  # GET /stats/1.json
  def show
  end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  def wios_v_airly
  end

  # POST /stats
  # POST /stats.json
  def create
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
        format.json { render :show, status: :created, location: @stat }
      else
        format.html { render :new }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/1
  # PATCH/PUT /stats/1.json
  def update
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat.destroy
    respond_to do |format|
      format.html { redirect_to stats_url, notice: 'Stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_params
      params.require(:stat).permit(:pm10, :pm25, :day, :station_id)
    end
end

class InstallationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  before_action :restrict_user, :only => [:show]
  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  # GET /installations
  # GET /installations.json
  def index
    @installations = Installation.all
  end

  def users
    @users = User.all
  end

  # GET /installations/1
  # GET /installations/1.json
  def show
  end

  # GET /installations/new
  def new
    @installation = Installation.new
  end

  # GET /installations/1/edit
  def edit
  end

  # POST /installations
  # POST /installations.json
  def create
    @installation = Installation.new(installation_params)

    respond_to do |format|
      if @installation.save
        format.html { redirect_to @installation, notice: 'Installation was successfully created.' }
        format.json { render :show, status: :created, location: @installation }
      else
        format.html { render :new }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /installations/1
  # PATCH/PUT /installations/1.json
  def update
    respond_to do |format|
      if @installation.update(installation_params)
        format.html { redirect_to @installation, notice: 'Installation was successfully updated.' }
        format.json { render :show, status: :ok, location: @installation }
      else
        format.html { render :edit }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installations/1
  # DELETE /installations/1.json
  def destroy
    @installation.destroy
    respond_to do |format|
      format.html { redirect_to installations_url, notice: 'Installation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def options
    puts params
    Setting.title = params[:options][:title]
    Setting.subtitle = params[:options][:subtitle]
    Setting.about = params[:options][:about]
    Setting.smtp_login = params[:options][:smtp_login]
    Setting.smtp_password = params[:options][:smtp_password]
    Setting.smtp_host = params[:options][:smtp_host]
    Setting.notif_on = params[:options][:notif_on]
    Setting.api_key1 = params[:options][:api_key1]
    Setting.api_key2 = params[:options][:api_key2]
    Setting.api_key3 = params[:options][:api_key3]
    Setting.api_key4 = params[:options][:api_key4]
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installation
      @installation = Installation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def installation_params
      params.require(:installation).permit(:name, :sensor_id)
    end

    def check_if_admin
      unless current_user.is_admin
        redirect_to "/"
        flash[:alert] = "Dostęp tylko dla administracji"
      end
    end

    def restrict_user
      redirect_to :installations
    end
end

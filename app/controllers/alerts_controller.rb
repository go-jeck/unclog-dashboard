class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.all
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
  end

  # GET /alerts/1/edit
  def edit
    logger.info("Asdasd")
    @alert = Alert.find(params[:id])

    duration = @alert.duration.to_i
    @hour = duration / 3600
    duration = duration % 3600
    @minute = duration / 60
    duration = duration % 60
    @second = duration
  end

  # POST /alerts
  # POST /alerts.json
  def create
    receivers = params['receiver']
    callback = Hash.new
    callback["type"] = params['callback']
    callback["receivers"] = receivers

    @alert = Alert.new()
    @alert.app_name = params['app_name'].downcase
    @alert.log_level = params['log_level'].downcase
    @alert.duration = params['duration']
    @alert.limit = params['limit']
    @alert.callback = callback.to_json

    @alert.save
    redirect_to alerts_path
  end

  # PATCH/PUT /alerts/1
  # PATCH/PUT /alerts/1.json
  def update
    @alert = Alert.find(params[:id])

    receivers = params['receiver']
    callback = Hash.new
    callback["type"] = params['callback']
    callback["receivers"] = receivers

    @alert.app_name = params['app_name'].downcase
    @alert.log_level = params['log_level'].downcase
    @alert.duration = (params['hour'].to_i * 3600) + (params['minute'].to_i * 60) + params['second'].to_i
    @alert.limit = params['limit']
    @alert.callback = callback.to_json

    @alert.save
    redirect_to alerts_path
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy
    respond_to do |format|
      format.html {redirect_to alerts_url, notice: 'Alert was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_alert
    @alert = Alert.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def alert_params
    params.require(:alert).permit(:app_name, :log_level, :duration, :limit, :callback)
  end
end

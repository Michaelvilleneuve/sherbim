# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  place       :string
#  transport   :string
#  statut      :boolean
#  price       :float
#  date        :datetime
#  code        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  nbpart      :integer
#  longitude   :string
#  latitude    :string
#  category_id :integer
#

class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy,:participate, :terminate]
  before_action :check_user, only: [:edit, :update, :destroy, :participate, :terminate]

  # GET /services
  # GET /services.json
  def index
    @services = Service.where(statut: false).all
  end

  def participate
    @service.users << @current_user
    GlobalMailer.notifydemand(@service).deliver
    Transaction.create worker: @current_user, service: @service
    redirect_to root_path
  end

  def terminate
    @service.terminate
    redirect_to root_path
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    if !@current_user
      redirect_to @service, notice: 'Vous devez être connecté'
    else
      @service[:user_id] = @current_user.id
      @service[:code] = Time.now.to_formatted_s+@current_user.id.to_s
      @service[:statut] = false
    end

    respond_to do |format|
      if @service.save
        GlobalMailer.confirmservice(@current_user).deliver
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def unauth
      redirect_to @service, notice: 'Vous ne pouvez pas répondre à cette demande'
    end
    def set_service
      @service = Service.find(params[:id])
    end
    # Check if the right user is modifying the entry
    def check_user
      if @current_user.id != @service.user_id
        unless @current_user[:role] == 'admin'
          redirect_to root_path
        end
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:user_id, :title, :description, :place, :transport, :price, :date, :code, :nbpart, :longitude, :latitude, :category_id)
    end
end

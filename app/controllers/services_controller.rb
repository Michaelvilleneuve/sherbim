class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy,:participate, :terminate]
  before_action :check_user, only: [:edit, :update, :destroy, :terminate]

  # GET /services
  # GET /services.json
  def index
    @services = Service.where(:statut => false).all
  end

  def participate
    if params[:id] && @current_user
      if @service
        pass = true
        @service.participants.each do |participant|
          if participant.user_id == @current_user.id
            pass = false
          end
        end
        if (@service[:user_id] == @current_user.id)
          unauth
        elsif(!pass)
          unauth
        end
        if (@service[:nbpart] > @service.participants.count)
          participant_params = {}
          participant_params[:user_id] = @current_user.id
          participant_params[:service_id] = params[:id]
          @participant = Participant.new(participant_params)
          if @participant.save
            Transaction.prepareTransfert(@service[:user_id], @current_user.id, @service[:amount], @service[:id])
            redirect_to @service, notice: 'Vous participez désormais à cet évènement !'
          end
        end 
      else 
        redirect_to root_path
      end
    else 
      redirect_to root_path
    end
  end

  def terminate
    if params[:id]
      unless @service[:statut]
        @service[:statut] = true
        @service.save
        Transaction.execute(@service[:id])
        redirect_to @service, notice: "Parfait, vos sauveteurs ont été récompensés !"
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
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
        redirect_to root_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:user_id, :title, :description, :place, :transport, :price, :date, :code, :nbpart, :longitude, :latitude, :category_ids)
    end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:show, :edit, :update, :destroy]

  # Make someone admin
  def makeadmin
    User.makeadmin(@current_user[:id])
    redirect_to @current_user, notice: 'Tu es maintenant admin.'
  end
  # GET /users
  # GET /users.json
  def index
    if @current_user[:role] == 'admin'
      @users = User.all
    else 
      redirect_to root_path
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @services = Service.where(:user_id => @user[:id]).all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user[:points] = 100

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user_info = User.find(params[:id])
    if !user_info.points
      @user[:points] = 100
    end
    if !user_info.image
      @user[:image] = 'http://graph.facebook.com/'+user_info.uid.to_s+'/picture?width=360&height=210'
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def check_user
      if @current_user.id != @user.id
        unless @current_user[:role] == 'admin'
          redirect_to root_path
        end
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :firstname, :description, :email, :phone, :age, :image)
    end
end

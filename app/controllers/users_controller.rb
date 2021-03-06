class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if user_signed_in?
     @users = User.all
   else
    redirect_to new_user_session_url
  end
end

  # GET /users/1
  # GET /users/1.json
  def show
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
#added friend by Email
  def search
    @user=User.find_by_email(params[:search])
    @friend = Friend.new()    
    @friend.user_id = current_user.id
    # condition to prevent current user to add himself and check if friend is added before
    if User.exists?(:email=>params[:search])

      if @user.id !=  current_user.id && !Friend.exists?(:user_id=>current_user.id ,:friend_id =>@user.id ) 
        @friend.friend_id=@user.id
        respond_to do |format|
          if @friend.save
            format.html { redirect_to :controller => 'friends' , :action => 'index' , :data => @user.id }
          end
      end
      else
        respond_to do |format|
        format.html { redirect_to :controller => 'friends' , :action => 'index' , :data => @user.id }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :controller => 'friends' , :action => 'index'}
      end
    end
  end 


def invite
    @user=User.find_by_name(params[:search])
    @friend_invite = Invitation.new()    
    @friend_invite.user_id =@user.id

    @friend_invite.order_id=params[:order_id]
    @friend_invite.is_join=false
    respond_to do |format|
      if @friend_invite.save
     #redirect_to :action => 'index' to redirect same page
    format.html { redirect_to :controller => 'invitations' , :action => 'index' , :data => @order_id  }
      # format.json { render :show, status: :ok, location: @user }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :email, :image)
      accessible = [ :name, :email ,:provider ,:uid ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
  end

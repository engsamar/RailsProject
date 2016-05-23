class GroupsUsersController < ApplicationController
  #before_action :set_groups_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /groups_users
  # GET /groups_users.json
  def index
    @groups_user = GroupsUser.find(params[:id])
    @groups_users = GroupsUser.all
  end

  # GET /groups_users/1
  # GET /groups_users/1.json
  def show
  end

  # GET /groups_users/new
  def new
    @groups_user = GroupsUser.find(params[:id])
    @groups_user = GroupsUser.new
  end

  # GET /groups_users/1/edit
  def edit
  end

  # POST /groups_users
  # POST /groups_users.json
  def create
    @groups_user = GroupsUser.find(params[:id])
    @groups_user = GroupsUser.new(groups_user_params)
    # @groups_user.user_id=1
    # @groups_user.group_id=3
    # respond_to do |format|
      if @groups_user.save
        redirect_to groups_url
      #   format.html { redirect_to groups_url, notice: 'Groups user was successfully created.' }
      #   format.json { render :show, status: :created, location: @groups_user }
      else
        format.html { render :new }
        format.json { render json: @groups_user.errors, status: :unprocessable_entity }
      end
    # end
  end

  #search for friend by name
  def search
    user_id=current_user.id
    friend=User.find_by_name(params[:search])
    if friend.present?
      is_friend=Friend.where(user_id: user_id, friend_id: friend.id)
      puts '************************'
      puts is_friend
      if is_friend.present?
        is_old_friend=GroupsUser.where(group_id: params[:group_id] , user_id:friend.id )
        if is_old_friend.present?
          redirect_to :controller => 'groups' , :action => 'show' , :data => params[:group_id]
        else
          @group_user = GroupsUser.new()
          @group_user.user_id=  friend.id
          @group_user.group_id=params[:group_id]
          respond_to do |format|
            if @group_user.save
              format.html { redirect_to :controller => 'groups' , :action => 'show' , :data => params[:group_id] }
            else
              @alert=params[:search] + 'process not complete'
              format.html { redirect_to :controller => 'groups' , :action => 'show' , :data => params[:group_id] }
            end
          end
        end
      else
        @alert=params[:search] + 'not a friend'
        redirect_to :controller => 'groups' , :action => 'show' , :data => params[:group_id]
      end
    else
      @alert=params[:search] + 'not a user'
      redirect_to :controller => 'groups' , :action => 'show' , :data => params[:group_id]
    end
  end


  # PATCH/PUT /groups_users/1
  # PATCH/PUT /groups_users/1.json
  def update
    @groups_user = GroupsUser.find(params[:id])
    respond_to do |format|
      if @groups_user.update(groups_user_params)
        format.html { redirect_to @groups_user, notice: 'Groups user was successfully updated.' }
        format.json { render :show, status: :ok, location: @groups_user }
      else
        format.html { render :edit }
        format.json { render json: @groups_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups_users/1
  # DELETE /groups_users/1.json
  def destroy
    group_id=params[:group]
    puts '***********************'
    puts group_id
    puts params[:id]
    puts params
    @groups_user = GroupsUser.where(user_id:params[:id], group_id: group_id)
    @groups_user.destroy
    redirect_to :controller => 'groups' , :action => 'show' , :data => params[:group]

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_groups_user
    #   @groups_user = GroupsUser.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def groups_user_params
       params.require(:groups_user).permit(:user_id,:group_id)
    end
end

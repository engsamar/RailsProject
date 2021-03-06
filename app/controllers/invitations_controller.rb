class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params)

    #@invitation.order_id=params[:order_id]
    @invitation.is_join=false
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to orders_path }
        format.html { redirect_to @invitation }

        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation}
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end
  #get /invitations/join/1

  def join
    @id  = params[:id]
    invite =   Invitation.find_by("id = ?",@id)
    invite.is_join = true
    invite.save
    redirect_to :controller => 'orders' ,:action => 'show' , :id => invite.order_id
    # respond_to do |format|
    #   if @invitation.update(invitation_params)
    #     format.html { redirect_to :controller => 'invitations' , :action => 'index'}
    #     format.json { render :show, status: :ok, location: @invitation }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @invitation.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:is_join, :user_id, :order_id)
    end
end

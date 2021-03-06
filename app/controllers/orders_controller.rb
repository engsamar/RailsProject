class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @invits = Invitation.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show

  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.status="Waiting";
    respond_to do |format|
      if @order.save
        #format.html { redirect_to :controller => 'invitations' , :action => 'new' }
        format.html { redirect_to order_url(@order)  }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def finish
    Order.where( id: params[:id] ).update_all( status: 'finished' )
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :restaurant, :menu_img, :date, :user_id)
    end
end

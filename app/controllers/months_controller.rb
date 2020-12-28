class MonthsController < ApplicationController
  before_action :set_month, only: [:show, :update, :destroy]

  # GET /months
  def index
    @months = Month.all

    render json: @months
  end

  # GET /months/1
  def show
    render json: @month
  end

  # POST /months
  def create
    @month = Month.new(month_params)

    if @month.save
      render json: @month, status: :created, location: @month
    else
      render json: @month.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /months/1
  def update
    if @month.update(month_params)
      render json: @month
    else
      render json: @month.errors, status: :unprocessable_entity
    end
  end

  # DELETE /months/1
  def destroy
    @month.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_month
      @month = Month.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def month_params
      params.require(:month).permit(:month)
    end
end

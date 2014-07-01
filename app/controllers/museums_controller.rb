class MuseumsController < ApplicationController
  before_action :set_museum, only: [:show]

  def index
    @museums = Museum.all 
  end

  def show 
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_museum
      @museum = Museum.find(params[:id])
    end

  #   # Never trust parameters from the scary internet, only allow the white list through.
    def museum_params
      params.require(:museum).permit(:name, :location)
    end


end
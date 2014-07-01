class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: [:show, :hover_mask]

  def show
    respond_to do |format|
      format.html
      format.json { render json: { date: @exhibition.date, museum_name: @exhibition.museum.name } }
    end
  end

  def hover_mask
    render partial: 'exhibitions/mask'
  end

  def index
    @exhibitions = Exhibition.all 
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_exhibition
      @exhibition = Exhibition.find(params[:id])
    end

  #   # Never trust parameters from the scary internet, only allow the white list through.
    def exhibition_params
      params.require(:exhibition).permit(:name, :date, :image_url, :image_desc, :description)
    end

end
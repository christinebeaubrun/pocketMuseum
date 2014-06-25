class Museum < ApplicationController
  # routes listed here

  def index
    
  end

  def show
    @exhibition = Museum.find(params[:id])
  end


end
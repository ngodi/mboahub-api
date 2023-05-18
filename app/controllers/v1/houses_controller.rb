module V1
  class HousesController < ApiController
    skip_before_action :authenticate_token!

    def show
      @show ||= House.includes(:house_images).find(params[:id])
    end

    def index
      @index ||= House.includes(:house_images).all
    end
  end
end

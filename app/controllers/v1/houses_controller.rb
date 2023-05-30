module V1
  class HousesController < ApiController
    skip_before_action :authenticate_token!

    def show
      @house = House.includes(:house_images).find(params[:id])
    end

    def index
      limit = params[:limit] || 6
      page = params[:page] || 0
      @houses = House
        .includes(:house_images)
        .limit(limit.to_i)
        .offset((page.to_i * limit.to_i)).order(created_at: :desc)
    end
  end
end

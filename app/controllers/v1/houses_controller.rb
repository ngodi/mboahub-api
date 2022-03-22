module V1
    class HousesController < ApiController
        skip_before_action :authenticate_token!

        def show
            @house ||= House.includes(:house_images).find(params[:id])
        end

        def index
            @houses = House.includes(:house_images).all
        end
    end
end


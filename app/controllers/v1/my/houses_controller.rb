module V1
  module My
    class HousesController < ApiController
      def create
        @house = Houses::HouseCreator.new(user: @current_user, house_params: house_params,
                                          images: params[:images]).create!
      end

      def update
        @house = Houses::HouseUpdater.new(user: @current_user, house_params: house_params,
                                          images: params[:images]).update!
      end

      def index
        @houses = @current_user.houses.includes(:house_images).all
      end

      private

      def house_params
        params.require(:house).permit(
          :listing_name,
          :summary,
          :home_type,
          :cost,
          :city,
          :street,
          :country,
          :lat,
          :lng,
          :num_bed_rooms,
          :sitting_room,
          :parking,
          :kitchen,
          :fence,
          :num_toilets,
          :business_type,
          :total_area,
          :dimensions,
          :has_title
        )
      end
    end
  end
end

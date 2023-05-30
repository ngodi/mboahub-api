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
          location: %i[city street country lat lng],
          properties: %i[num_bed_rooms sitting_room parking kitchen fence num_toilets]
        )
      end
    end
  end
end

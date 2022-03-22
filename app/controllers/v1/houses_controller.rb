module V1
    class HousesController < ApiController
        def create
            @house = Houses::HouseCreator.new(user: @current_user, house_params: house_params, images: params[:images]).create!

            render json: { error: @house.errors.full_messages } if @house.errors.any?

        rescue ActiveRecord::NotNullViolation => _
            render json: { error: "check required fields and try again" }
        rescue ActiveRecord::RecordInvalid => e
            render json: { error: e.message }
        rescue ActiveRecord::RecordNotUnique => _
            render json: { error: "duplicate key value violates unique constraint" }, status: 409
        end

        def show
            @house ||= House.includes(:house_images).find(params[:id])
        end

        def index
            @houses = House.includes(:house_images).all
        end


        private

        def house_params
            params.require(:house).permit(
                :listing_name,
                :summary,
                :home_type,
                :cost,
                location: [:city, :street],
                properties: [:num_bed_rooms, :sitting_room, :parking, :kitchen, :fence, :num_toilets],
            )
        end
    end
end


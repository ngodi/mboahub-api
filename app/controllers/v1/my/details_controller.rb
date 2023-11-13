module V1
  module My
    class DetailsController < ApiController
      def index
        @current_user
      end

      def update
        @current_user.update!(user_info_params)
        @current_user.addresses.clear
        @current_user.addresses.create!(user_address_params)
      end

      private

      def user_info_params
        params.require(:personal).permit(:first_name,
                                         :last_name,
                                         :image_url,
                                         :image_cover_url,
                                         :agency,
                                         :about,
                                         :phone,
                                         :facebook_url,
                                         :twitter_url,
                                         :instagram_url)
      end

      def user_address_params
        params.require(:address).permit(:city, :street, :country)
      end
    end
  end
end

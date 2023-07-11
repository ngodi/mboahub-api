module V1
  class HousesController < ApiController
    skip_before_action :authenticate_token!

    def show
      @house = House.includes(:house_images).find(params[:id])
    end

    def index
      @houses = House.includes(:house_images)
        .limit(house_params[:limit])
        .offset((house_params[:page] * house_params[:limit])).order(created_at: :desc)

      if house_params[:listing_name]
        @houses = @houses.where('lower(listing_name) like ?',
                                "%#{house_params[:listing_name]}%")
      end
      if house_params[:location]
        @houses = @houses.where('lower(city) like ? OR lower(street) like ? OR lower(country) like ?', "%#{house_params[:location]}%",
                                "%#{house_params[:location]}%", "%#{house_params[:location]}%")
      end
      return unless house_params[:business_type]

      @houses = @houses.where('lower(business_type) like ?',
                              "%#{house_params[:business_type]}%")
    end

    private

    def house_params
      {
        limit: params[:limit].to_i || 6,
        page: params[:page].to_i || 0,
        listing_name: params[:listingName]&.downcase,
        location: params[:location]&.downcase,
        business_type: params[:businessType]&.downcase
      }
    end
  end
end

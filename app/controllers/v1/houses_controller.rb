# rubocop:disable Style/CyclomaticComplexity

module V1
  class HousesController < ApiController
    skip_before_action :authenticate_token!

    def show
      @house = House.includes(:house_images).find(params[:id])
    end

    def index
      @houses = Houses::HousesFilter.new(
        {
          listing_name: params[:listingName]&.downcase,
          location: params[:location]&.downcase,
          limit: params[:limit] || 6,
          page: params[:page] || 1,
          business_type: params[:businessType]&.downcase,
          city: params[:city]&.downcase,
          street: params[:street]&.downcase,
          country: params[:country]&.downcase,
          home_type: params[:homeType]&.downcase
        }
      ).filter
    end
  end
end

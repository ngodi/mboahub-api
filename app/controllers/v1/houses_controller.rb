module V1
  class HousesController < ApiController
    skip_before_action :authenticate_token!

    def show
      @house = House.includes(:house_images).find(params[:id])
    end

    def index
      limit = params[:limit] || 6
      page = params[:page] || 0
      listing_name = params[:listingName]
      location = params[:location]
      business_type = params[:businessType]

      @houses = House.includes(:house_images)
        .limit(limit.to_i)
        .offset((page.to_i * limit.to_i)).order(created_at: :desc)

      @houses = @houses.where('listing_name like ?', listing_name) if listing_name
      @houses = @houses.where('location like ?', location) if location
     
      @houses = @houses.where('business_type like ?', business_type) if business_type
    end
  end
end

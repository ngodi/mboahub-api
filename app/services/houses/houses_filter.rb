module Houses
  class HousesFilter
    def initialize(payload = nil)
      @houses = House.includes(:house_images)
        .limit(payload[:limit])
        .offset((payload[:page].to_i * payload[:limit].to_i)).order(created_at: :desc)
      @payload = payload
    end

    # rubocop:disable Style/CyclomaticComplexity
    def filter
      # rubocop:enable Style/CyclomaticComplexity
      @houses = filter_by('listing_name') if @payload[:listing_name]
      @houses = filter_by('city') if @payload[:city]
      @houses = filter_by('street') if @payload[:street]
      @houses = filter_by('country') if @payload[:country]
      @houses = filter_by('home_type') if @payload[:home_type]
      @houses = filter_by('business_type') if @payload[:business_type]
      @houses = filter_by_location if @payload[:location]

      @houses
    end

    private

    def filter_by(field)
      @houses.where("lower(#{field}) like ?", "%#{@payload[field]}%")
    end

    def filter_by_location
      @houses.where('lower(city) like ? OR lower(street) like ? OR lower(country) like ?',
                    "%#{@payload[:location]}%",
                    "%#{@payload[:location]}%",
                    "%#{@payload[:location]}%")
    end
  end
end

module Houses
  class HouseCreator
    attr_reader :user, :house_params, :images

    def initialize(user:, admin_user:, house_params:, images:)
      @user = user
      @admin_user = admin_user
      @house_params = house_params # .except(:images)
      @images = images
    end

    def create!
      ActiveRecord::Base.transaction do
        user.houses.create!(house_params.merge({ admin_user: @admin_user }))
        #  if images
        #     images.each do |image|
        #       house.images.attache(image)
        #     end
        #  end

        # .tap do |house|
        # house.update!(house_params)
        # house.save!
        # images&.map do |image|
        #   HouseImage.create!(image_url: image.url, house_id: house.id)
        # end
        # end
      end
    end
  end
end

# frozen_string_literal: true

ActiveAdmin.register House do
  # permit_params house_params
  remove_filter :admin_user, :images_attachments, :images_blobs
  config.sort_order = 'created_at_desc'

  index do
    selectable_column
    id_column
    column :listing_name
    column :home_type
    column :country
    column :city
    column :business_type
    column :total_area
    column :dimensions
    column :has_title
    actions
  end

  show do
    attributes_table do
      row :listing_name
      row :summary
      row :home_type
      row :cost
      row :city
      row :street
      row :country
      row :num_bed_rooms
      row :sitting_room
      row :parking
      row :kitchen
      row :fence
      row :num_toilets
      row :business_type
      row :total_area
      row :dimensions
      row :has_title
      row :lat
      row :lng
      row :images do |house|
        house.images.each do |image|
          span do
            image_tag(image, size: '100x100')
          end
        end
      end
    end
  end

  controller do
    def create
      @city = params[:city]

      updated_params = house_params.merge({ lat: default_lat, lng: default_lng })

      @house = Houses::HouseCreator.new(user: User.first, admin_user: current_admin_user, house_params: updated_params,
                                        images: params[:images]).create!
      super
    end

    def default_lat
      geocode&.first&.data['lat'].to_f || 1.02
    end

    def default_lng
      geocode&.first&.data['lon'].to_f || 1.02
    end

    def geocode
      Geocoder.configure(timeout: 1000)

      Geocoder.search(@city)
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
        :num_bed_rooms,
        :sitting_room,
        :parking,
        :kitchen,
        :fence,
        :num_toilets,
        :business_type,
        :total_area,
        :dimensions,
        :has_title,
        :lat,
        :lng,
        images: []
      )
    end
  end

  form do |f|
    f.inputs 'House Details' do
      f.input :listing_name
      f.input :summary
      f.input :home_type, as: :select, collection: House::HOME_TYPE
      f.input :cost
      f.input :business_type, as: :select, collection: House::BUSINESS_TYPE
      f.input :street
      f.input :country, as: :select, collection: ISO3166::Country.countries,
                        input_html: { data: { controller: 'select' } }
      f.input :city
      f.hidden_field :lat
      f.hidden_field :lng
      f.input :num_bed_rooms
      f.input :sitting_room
      f.input :kitchen
      f.input :fence
      f.input :parking
      f.input :num_toilets
      f.input :has_title
      f.input :dimensions
      f.input :total_area
    end

    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true }
    end

    f.actions
  end
end

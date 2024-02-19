ActiveAdmin.register User do
  controller do
    def create
      CanCreateUser.new(current_admin_user).authorize!
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :role, as: :select, collection: %w[admin agent]
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :about
      f.input :phone
      f.input :facebook_url
      f.input :twitter_url
      f.input :instagram_url
      f.input(:image_url, as: :file, label: 'Image Url', accept: 'image/png, image/gif, image/jpeg')
      f.input(:image_cover_url, as: :file, label: 'Image Cover Url', accept: 'image/png, image/gif, image/jpeg')
    end
    f.actions
  end
end

class User < ApplicationRecord
    jsonb_accessor :data,
    city: :string,
    street: :string
end

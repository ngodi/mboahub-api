module Auth
   class UserCreator
      attr_reader :user_params

      def initialize(user_params:)
         @user_params = user_params
      end

      def create!
         User.create!(user_params)
      end
   end
end

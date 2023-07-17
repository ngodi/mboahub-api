module V1
  module My
    class PasswordController < ApiController
      def update
        if @current_user.authenticate(params[:current_password])
          @current_user.update!(password_params)
          @result = true
        else
          @result = false
        end

        @result
      end

      private

      def password_params
        params.permit(:password, :password_confirmation)
      end
    end
  end
end

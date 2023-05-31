module HandleResponse
  extend ActiveSupport::Concern

  def handle_not_found_exception(error)
    render_response({ errors: error.message }, 404)
  end

  def render_422_response(resource)
    render_response({ errors: resource&.errors }, 422)
  end

  def render_400_response(errors)
    render_response({ errors: errors }, 400)
  end

  def render_response(response, status = nil)
    status = 200 if status.blank?
    success = true
    success = false unless status.between?(200, 299)
    render(json: { data: response, success: success }, status: status)
  end

  def invalid_error(err)
    render json: { errors: [err], success: false }, status: 422
  end

  def not_found_error
    render json: { errors: ['Invalid email or password'], success: false }, status: 404
  end

  def validation_error(resource)
    render json: { errors: [resource.errors.full_messages] }, status: 409
  end
end
